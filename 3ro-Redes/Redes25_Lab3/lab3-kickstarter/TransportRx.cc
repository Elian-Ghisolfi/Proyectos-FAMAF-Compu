#ifndef TRANSPORTRX_H
#define TRANSPORTRX_H

#include <omnetpp.h>
#include "Queue.h"
#include "FeedbackPkt_m.h"

using namespace omnetpp;

class TransportRx: public Queue {
private:
    int dropeados;
    bool flujoDetected;
    double avgDelay;
    int count;
    double historyDelay;
    cMessage *congestionMessage;     // Creamos un evento para medir la congestion en x tiempo
    bool congestionEvent;
    double delayPoint;             //  Punto (porcentaje en decimal) para considerar congestión
public:
    TransportRx();
    virtual ~TransportRx() override;

protected:
    virtual void initialize() override;
    virtual void finish() override;
    virtual void handleMessage(cMessage *msg) override;
    
};

Define_Module(TransportRx);

TransportRx::TransportRx() {
    //endServiceEvent = NULL;
}

TransportRx::~TransportRx() {
    //cancelAndDelete(endServiceEvent);
    cancelAndDelete(congestionMessage);
}

void TransportRx::initialize() {
    // Inicializar variables heredadas de Queue
    Queue::initialize();
    dropeados = 0;
    flujoDetected = false;
    congestionMessage = new cMessage("congestionReset");
    congestionEvent = true;                                 //controlamos un primer evento
    avgDelay = 0.0;
    delayPoint = par("delayPoint").doubleValue();
    historyDelay = 0.0;
    count = 0;
}

void TransportRx::finish() {
    Queue::finish();
    recordScalar("dropeados: ", dropeados);
}

void TransportRx::handleMessage(cMessage *msg) {

    // if msg is signaling an endServiceEvent
    if (msg == endServiceEvent) {
        // if packet in buffer, send next one
        if (!buffer.isEmpty()) {
            // dequeue packet
            cPacket *pkt = (cPacket*) buffer.pop();
            // send packet
            send(pkt, "toApp");

            // start new service
            serviceTime = pkt->getDuration();
            scheduleAt(simTime() + serviceTime, endServiceEvent);
        }
    }else if (msg == congestionMessage) { //Controlamos cuando se analiza la congestion
        congestionEvent = true;
        return;
    } else { // if msg is a data packet 
        //calculamos el delay del paquete recibido
        simtime_t currentDelay = simTime() - msg->getCreationTime();

        if (buffer.getLength() >= par("bufferSize").intValue()) {
            // if the buffer is full
            // drop the packet
            delete msg;
            this->bubble("Packet dropped");
            dropeados++;
            packetDropVector.record(dropeados);
        } else { 
            // enqueue the packet
            buffer.insert(msg);
            bufferSizeVector.record(buffer.getLength());
            // if the server is idle
            if (!endServiceEvent->isScheduled()) {
                // start the service
                scheduleAt(simTime() + 0, endServiceEvent);
            }
            //create el feedback para control de flujo
            if (buffer.getLength()>=par("bufferSize").intValue()*0.90 && !flujoDetected)  {
                //create el feedback
                FeedbackPkt* feedbackPkt = new FeedbackPkt();
                feedbackPkt->setByteLength(20);
                feedbackPkt->setKind(2);
                feedbackPkt->setPercentajeBuffer((float)buffer.getLength()/(float)par("bufferSize").intValue());
                //seteamos el delay en el feedback
                send(feedbackPkt, "toOut$o");
                flujoDetected=true;
            } else{
                if (buffer.getLength()<par("bufferSize").intValue()*0.90 || buffer.getLength()>par("bufferSize").intValue()*0.95){
                    flujoDetected=false;
                }
            }

            // creamos el feedback para control de congestion
            // Tomamos el delay
            /*
            PARAMETROS PARA .INI
            Network.nodeRx.traRx.delayPoint=1.3
            Network.nodeTx.traTx.maxProportion=3.9
            Network.nodeTx.traTx.minProportion=1
            */
            simtime_t currenteDelay = simTime() - msg->getTimestamp();
            // Promedio con los 10 primeros paquetes con los paquetes que van llegando
            if (count < 10) {
                historyDelay += currenteDelay.dbl();
                count++;
            }else if (count == 10){
                avgDelay = historyDelay / count;
                count++;
            }
            //Hubo un delay
            if (congestionEvent && (currenteDelay.dbl() > avgDelay * delayPoint) && count > 10) {
                // Porcentaje para el feedback
                double percentajeDelay = currenteDelay.dbl() / avgDelay;
                //create el feedback
                FeedbackPkt* feedbackPkt1 = new FeedbackPkt();
                feedbackPkt1->setByteLength(20);
                feedbackPkt1->setKind(3);
                feedbackPkt1->setPercentajeBuffer(0.0);
                //seteamos el delay en el feedback
                feedbackPkt1->setPercentajeDelay(percentajeDelay);
                //mandamos el feedback
                send(feedbackPkt1, "toOut$o");
                // Programamos un evento para controlar el delay
                scheduleAt(simTime() + 6, congestionMessage);
                // Fin del evento de control
                congestionEvent = false;                
            }
            // Actualizamos solo con los Delay que estan en rango aceptable
            if (count > 10 && (currenteDelay.dbl() > avgDelay * (delayPoint + 0.6))) {
                avgDelay = 0.8 * avgDelay + 0.2 * currenteDelay.dbl();  // Promedio móvil(ponderado) con factor 0.2
            }
        }
    }
}

#endif /* TRANSPORTRX_H */
