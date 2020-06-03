FROM alpine:3.5

RUN apk update
RUN apk add bash
RUN apk add ca-certificates
RUN apk add wget

WORKDIR /etc/apk/keys
RUN wget https://dist.sapmachine.io/alpine/sapmachine%40sap.com-5a673212.rsa.pub

WORKDIR /

RUN echo "http://dist.sapmachine.io/alpine/3.5" >> /etc/apk/repositories

RUN apk update
RUN apk add sapmachine-10-jre
