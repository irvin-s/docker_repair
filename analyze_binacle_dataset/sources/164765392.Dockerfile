FROM debian:wheezy
MAINTAINER Daniël van Eeden <docker@myname.nl>

RUN apt-get update
RUN apt-get install -y wget
RUN wget -qO /root/infobright-4.0.7-0-x86_64-ice.deb http://www.infobright.org/downloads/ice/infobright-4.0.7-0-x86_64-ice.deb
RUN dpkg -i /root/infobright-4.0.7-0-x86_64-ice.deb
