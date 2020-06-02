FROM debian:latest
MAINTAINER Cajus Pollmeier <pollmeier@gonicus.de>
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get remove rpcbind && \
    apt-get -y install mosquitto mosquitto-auth-plugin && \
    apt-get clean

USER root
COPY start.sh /root

EXPOSE 1883 8883
ENTRYPOINT /root/start.sh
