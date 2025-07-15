#ifndef TRANSPORTTX_H
#define TRANSPORTTX_H

#include <omnetpp.h>
#include "Queue.h"
#include "FeedbackPkt_m.h"

using namespace omnetpp;

class TransportTx: public Queue {
private:
    //Atributos para el control
    double currentProportion;      // Proporcion (porcentaje en decimal) de envío actual 
    double maxProportion;          // Proporcion (porcentaje en decimal) maxima del tiempo para el proximo envio = 1
    double minProportion;          // Proporcion (porcentaje en decimal) minima del tiempo para el proximo envío = 1.5
    double regulationFactor;       // Factor que regula las proporciones
    bool congestionDetected;       // Flag para indicar si hay congestión
    
public:
    TransportTx();
    virtual ~TransportTx();

protected:
    virtual void initialize() override;
    //virtual void finish();
    virtual void handleMessage(cMessage *msg) override;
};

Define_Module(TransportTx);

TransportTx::TransportTx() {
    //endServiceEvent = NULL;
}

TransportTx::~TransportTx() {
    //cancelAndDelete(endServiceEvent);
}

void TransportTx::initialize() {
    // Inicializar variables heredadas de Queue
    Queue::initialize();
    
    // Inicializar variables para control de congestión
    currentProportion = 1.0; // inicializamos en condiciones normales
    maxProportion = par("maxProportion").doubleValue();
    minProportion = par("minProportion").doubleValue();
    regulationFactor = 0.05; // Nota: se podria pasar como parametro de simulacion
    congestionDetected = false;
}


//void TransportTx::finish() {


void TransportTx::handleMessage(cMessage *msg) {

    // if msg is signaling an endServiceEvent
    if (msg == endServiceEvent) {
        // if packet in buffer, send next one
        if (!buffer.isEmpty()) {
            // dequeue packet
            cPacket *pkt = (cPacket*) buffer.pop();
            pkt->setTimestamp();
            // send packet
            send(pkt, "toOut$o");
            // start new service
            serviceTime = pkt->getDuration();
            // Disminuimos la proporcion solo si se aumentó
            if (currentProportion>=minProportion+regulationFactor){
                currentProportion-=regulationFactor;
            }
            // aumentamos proporcionalmente el serviceTime para controlar el envio de paquetes
            scheduleAt(simTime() + (serviceTime*currentProportion), endServiceEvent);
        }

    }else if(msg->getKind()==2){
        
        FeedbackPkt* feedbackPkt = (FeedbackPkt*)msg;
        // Algoritmo para control de flujo simple si el buffer de NodeRx está cerca de llenarse (a un 70% o 30% libre)
        // si hay problemas de flujo en NodeRx bajaremos un 66% el envio de paquetes
        // Teniendo en cuenta la congestion
        float percentaje=feedbackPkt->getPercentajeBuffer();
        if (percentaje>0 && percentaje<=0.95) {
                currentProportion *= 3;//Baja un 66%

        }else if (percentaje>0 && percentaje<=1){
                currentProportion *= 5;//Baja un 80%
        }
        delete (msg);
    
        //Algoritmo para control de la Congestion
    }else if (msg->getKind()==3) {
        FeedbackPkt* feedbackPkt = (FeedbackPkt*)msg;
        float percentajeDelay = feedbackPkt->getPercentajeDelay();
    // Ajuste más gradual según la severidad del problema
    if (percentajeDelay > 0) {
        if (percentajeDelay >= 2) {
            // Congestión severa - reducir la tasa de envío significativamente
            currentProportion *= 5; // Reducimos un 80%
            this->bubble("Congestion Severa");        
        } else if (percentajeDelay >= 1.6) {
            // Congestión moderada
            currentProportion *= 3; // Reducimos un 66%
            this->bubble("Congestion Moderada");        
        } else {
            // Congestión leve
            currentProportion *= 2.5; // Reducimos un 58%
            this->bubble("Congestion Leve");        
        }
        
        //Limitamos el crecimiento del currentProportion para evitar que la cola se vacíe
        if (currentProportion > maxProportion) {
            currentProportion = maxProportion;
        }
    }   
        delete(msg);

    }else if (msg->getKind()==0) {
        // msg is a data packet
        if (buffer.getLength() >= par("bufferSize").intValue()) {
        // if the buffer is full
        // drop the packet
            delete msg;
            this->bubble("Packet dropped");
            packetDropVector.record(1);
        } else { // if msg is a data packet
            // enqueue the packet
            buffer.insert(msg);
            bufferSizeVector.record(buffer.getLength());
            // if the server is idle
            if (!endServiceEvent->isScheduled()) {
                // start the service
                scheduleAt(simTime() + 0, endServiceEvent);
            }
        }
    }
}
#endif /* TRANSPORTTX_H */
