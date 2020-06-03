FROM ibmcom/icp-inception:2.1.0

RUN apk add --update python python-dev py-pip && \
    pip install softlayer
