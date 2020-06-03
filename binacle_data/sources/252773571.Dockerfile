FROM debian:jessie  
  
RUN apt-get update && \  
apt-get upgrade -y && \  
apt-get -y autoremove  
  
RUN apt-get install -y bind9 bind9-doc dnsutils git vim && \  
apt-get -y autoremove  
  
WORKDIR /etc/bind  
  
EXPOSE 53/udp  
  
CMD [ "service", "bind9", "start" ]  

