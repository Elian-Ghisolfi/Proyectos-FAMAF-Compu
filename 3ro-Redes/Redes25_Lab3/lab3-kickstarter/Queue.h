#ifndef QUEUE_H
#define QUEUE_H

#include <omnetpp.h>

using namespace omnetpp;

class Queue : public cSimpleModule {
private:

public:
    Queue();
    virtual ~Queue();

protected:
    cQueue buffer;
    cMessage *endServiceEvent;
    simtime_t serviceTime;
    int bufferSize;
    cOutVector bufferSizeVector;
    cOutVector packetDropVector;

    virtual void initialize() override;
    virtual void finish() override;
    virtual void handleMessage(cMessage *msg) override;
};

#endif /* QUEUE_H */
