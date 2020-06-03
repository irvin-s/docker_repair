FROM ubuntu:14.04  
MAINTAINER Cogniteev <tech@cogniteev.com>  
  
ENV RSYSLOG8_VERSION=8.14.0  
RUN apt-get install -y software-properties-common && \  
add-apt-repository ppa:adiscon/v8-stable && \  
apt-get update && \  
apt-get install -y "rsyslog=${RSYSLOG8_VERSION}-0adiscon1trusty1"  
  
# Copy config files of dependant images  
ONBUILD ADD rsyslog.d/* /etc/rsyslog.d/  
  
CMD rsyslogd -n  

