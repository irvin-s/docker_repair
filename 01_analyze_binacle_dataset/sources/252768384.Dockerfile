#Download base image ubuntu 16.04  
FROM ubuntu:16.04  
# Update Ubuntu Software repository and musql-server  
RUN apt-get update && apt-get -y install asterisk  
  
RUN sed -i "s/rtpstart=10000/rtpstart=16384/g" /etc/asterisk/rtp.conf  
RUN sed -i "s/rtpend=20000/rtpend=16394/g" /etc/asterisk/rtp.conf  
  
WORKDIR /etc/asterisk  
  
VOLUME /etc/asterisk  
VOLUME /var/lib/asterisk/moh  
  
EXPOSE 5060 5060/udp  
EXPOSE 16384/udp  
EXPOSE 16385/udp  
EXPOSE 16386/udp  
EXPOSE 16387/udp  
EXPOSE 16388/udp  
EXPOSE 16389/udp  
EXPOSE 16390/udp  
EXPOSE 16391/udp  
EXPOSE 16392/udp  
EXPOSE 16393/udp  
EXPOSE 16394/udp  
  
CMD ["/usr/sbin/asterisk", "-f"]  
  

