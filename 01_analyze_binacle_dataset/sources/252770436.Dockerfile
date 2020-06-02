FROM ubuntu:15.04  
MAINTAINER asmaps  
  
RUN apt-get update && apt-get install -y net-tools iodine iptables  
RUN mkdir -p /opt/iodine  
ADD start.sh /opt/iodine/start.sh  
  
WORKDIR /opt/iodine  
  
EXPOSE 53/udp  
  
CMD ["./start.sh"]  

