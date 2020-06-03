# stunnel Server  
#  
# VERSION 0.0.1  
# Building from CentOS 7  
FROM centos:centos7  
MAINTAINER i2O Water <anapos@i2owater.com>  
  
RUN yum -y update; yum clean all  
RUN yum -y install stunnel  
RUN mkdir /var/run/stunnel  
  
VOLUME ["/etc/stunnel"]  
  
ADD config/stunnel.conf /etc/stunnel/stunnel.conf  
ADD config/broker-cert.pem /etc/stunnel/broker-cert.pem  
ADD config/broker-key.pem /etc/stunnel/broker-key.pem  
ADD config/cacert.pem /etc/stunnel/cacert.pem  
  
EXPOSE 8883  
CMD [ "/usr/bin/stunnel" ]  

