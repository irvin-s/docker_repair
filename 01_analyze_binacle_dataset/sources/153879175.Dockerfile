FROM ubuntu:14.04

RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install apt-transport-https curl
RUN curl https://repo.varnish-cache.org/ubuntu/GPG-key.txt | apt-key add -
RUN echo "deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.0" >> /etc/apt/sources.list.d/varnish-cache.list
RUN apt-get update
RUN apt-get -y install varnish

ADD ./default.vcl /etc/varnish/default.vcl

RUN rm /etc/init.d/varnish

ADD ./start.sh /usr/local/bin/start.sh
ADD ./start_lb.sh /usr/local/bin/start_lb.sh
