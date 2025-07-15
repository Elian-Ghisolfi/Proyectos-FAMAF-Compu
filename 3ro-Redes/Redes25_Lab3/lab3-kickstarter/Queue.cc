#include "Queue.h"
#include "FeedbackPkt_m.h"

Define_Module(Queue);

Queue::Queue() {
    endServiceEvent = NULL;
}

Queue::~Queue() {
    cancelAndDelete(endServiceEvent);
}

void Queue::initialize() {
    buffer.setName("buffer");
    endServiceEvent = new cMessage("endService");
}

void Queue::finish() {
}

void Queue::handleMessage(cMessage *msg) {

    FeedbackPkt* feedbackPkt = dynamic_cast<FeedbackPkt*>(msg);
    if (feedbackPkt) {
        if (!buffer.isEmpty()) {
            // Si es un paquete de feedback, lo enviamos directamente
            FeedbackPkt *pkt = (FeedbackPkt*) buffer.pop();
            send(pkt, "out");
        }
    }
    
    // if msg is signaling an endServiceEvent
    if (msg == endServiceEvent) {
        // if packet in buffer, send next one
        if (!buffer.isEmpty()) {
            // dequeue packet
            cPacket *pkt = (cPacket*) buffer.pop();
            // send packet
            send(pkt, "out");
            // start new service
            serviceTime = pkt->getDuration();
            scheduleAt(simTime() + serviceTime, endServiceEvent);
        }
    } else if (buffer.getLength() >= par("bufferSize").intValue()) {
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

