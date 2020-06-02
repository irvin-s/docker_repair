FROM ubuntu:16.04
LABEL maintainer="OPNFV CONTAINER4NFV"

EXPOSE 22
RUN apt-get update -y
RUN apt-get install -y sudo openssh-server inetutils-ping
COPY start.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/start.sh
