# Version: 0.0.3 - Asterisk 14.3.0 with pjsip 2.5.5 and opus,g729 codecs  
FROM ubuntu:trusty  
MAINTAINER cd "cleardevice@gmail.com"  
ENV TERM=xterm  
ENV PJSIP_VERSION=2.5.5  
ENV OPUS_VERSION=1.1.4  
ENV ASTERISK_VERSION=14.3.0  
ADD ./conf /tmp  
ADD ./scripts /  
  
RUN /bin/sh /build.sh  
  
WORKDIR /etc/asterisk  
CMD ["/bin/sh", "/start.sh"]  

