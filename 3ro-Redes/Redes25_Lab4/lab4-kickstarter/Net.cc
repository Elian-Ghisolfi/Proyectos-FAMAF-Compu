#ifndef NET
#define NET

#include <string.h>
#include <omnetpp.h>
#include <packet_m.h>
#include <map>

using namespace omnetpp;
enum PacketType {HALO, DATA};


class Net: public cSimpleModule {
private:
    // bool flag;
    std::map<int,bool> decisionPerNode;
    std::vector<int> nodes; // Vector to store the nodes that have sent HALO packets
public:
    Net();
    virtual ~Net();
protected:
    virtual void initialize();
    virtual void finish();
    virtual void handleMessage(cMessage *msg);
    virtual void generarTabla();
};

Define_Module(Net);

#endif /* NET */

Net::Net() {
}

Net::~Net() {
}

void Net::initialize() {
    // If this is the first node, send a HALO packet
    Packet *pkt = new Packet("HALO");
    pkt->setSource(this->getParentModule()->getIndex());
    pkt->setDestination(-1);
    send(pkt, "toLnk$o", 0);
}

void Net::finish() {
}

void Net::generarTabla() {
    int myId = this->getParentModule()->getIndex();
    int N = nodes.size();
    int middle = N / 2;

    for (int i = 0; i < N; ++i) {
        int dest = nodes[i];
        if (dest == myId){continue;}

        int clockwise = 0; // horario
        int counterClockwise = 0; // antihorario
        //caso especial node[0]
        if (myId == 0 ){
            if (dest > middle){
                decisionPerNode[dest] = false;
            } else {
                decisionPerNode[dest] = true;
            }
            continue;
        }       
        // Calcular distancias en saltos con funcion 'mod'
        clockwise = (myId - dest + N) % N; // lnk[0] apunta hacia el nodo de mayor ID
        counterClockwise = (dest - myId + N) % N; // lnk[1] apunta hacia el nodo de menor ID
        
        // Elegir la dirección con menos saltos
        if (clockwise == counterClockwise) {
            int rnd = intuniform(1, 10);
            decisionPerNode[dest] = (rnd % 2 == 0);  
        } else if (clockwise < counterClockwise){
            decisionPerNode[dest] = false;  // Horario
            //routingTable[dest] = 0;  // interfaz horaria
        }else{
            decisionPerNode[dest] = true;   // Antihorario
            //routingTable[dest] = 1;  // interfaz antihoraria

        }
    }
}


PacketType getPacketType(Packet *pkt) {
    const char *name = pkt->getName();
    if (strcmp(name, "HALO") == 0) return HALO;
    return DATA;
}

void Net::handleMessage(cMessage *msg) {

    // All msg (events) on net are packets
    Packet *pkt = (Packet *) msg;

    switch (getPacketType(pkt))  // Check the type of the packet
    {
    case HALO:
        // Si el paquete es HALO vemos si estamos en el nodo que lo envio
        if (this->getParentModule()->getIndex() == pkt->getSource()) {
            // Si estamos en el nodo que envio, copiamos el arreglo con todos los nodos
            for (int i = 0; i < pkt->getNodesTmpArraySize(); i++) {
                nodes.push_back(pkt->getNodesTmp(i));
            }
            generarTabla();  // Function to generate the routing table
            delete(pkt); // ya no necesito el paquete HALO
        }else {
            // Si no estamos en el nodo 0, agregamos nuestro nodo al arreglo de nodos temporales
            pkt->insertNodesTmp(pkt->getNodesTmpArraySize(), this->getParentModule()->getIndex());
            // Y enviamos el paquete HALO al siguiente nodo
            send(pkt, "toLnk$o", 0);
        }
        break;
    default:
        // Si el paquete no es HALO y es un paquete con DATA verificamos:
    
        // If this node is the final destination, send to App
        if (pkt->getDestination() == this->getParentModule()->getIndex()) {
            send(msg, "toApp$o");
        }
        // Controlamos que no estemos en un bucle
        else if(pkt->getHopCount() > nodes.size()){
            // Si estamos en un bucle elinamos el paquete (no es la mejor opcion)
            delete (pkt);
        // Si no enviamos por el link del camino mas corto segun la tabla decisionPerNode
        }else{
            //Contamos los pasos
            pkt->setHopCount(pkt->getHopCount() + 1);
            int dest = pkt->getDestination();
            send(msg, "toLnk$o", decisionPerNode[dest]);
        }
    }
}
