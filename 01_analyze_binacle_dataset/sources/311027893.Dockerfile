FROM lnd:latest

RUN rm $GOPATH/bin/lnd
WORKDIR /root/
