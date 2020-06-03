# Version: 0.0.1 - Asterisk 13.7.2 with pjsip 2.4.5  
FROM ubuntu:trusty  
MAINTAINER cd "cleardevice@gmail.com"  
ENV ASTERISK_VERSION=13.7.2  
ENV PJSIP_VERSION=2.4.5  
ADD ./conf /tmp  
ADD ./scripts /  
  
RUN /bin/sh /build.sh  
  
WORKDIR /etc/asterisk  
CMD ["/bin/sh", "/start.sh"]  

