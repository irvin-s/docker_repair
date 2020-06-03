FROM ubuntu:14.04
MAINTAINER danb@renci.org

RUN apt-get update ; apt-get upgrade -y ; apt-get install -y wget libcurl4-gnutls-dev

RUN wget ftp://ftp.renci.org/pub/irods/releases/4.1.3/ubuntu14/irods-icommands-4.1.3-ubuntu14-x86_64.deb -O /tmp/icommands.deb
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y `dpkg -I /tmp/icommands.deb | sed -n 's/^ Depends: //p' | sed 's/,//g'`
RUN dpkg -i /tmp/icommands.deb

ENTRYPOINT [ "/bin/bash" ]
