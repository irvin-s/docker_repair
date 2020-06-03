FROM ubuntu  
  
RUN \  
apt-get update && \  
apt-get -y install runit curl iputils-ping dnsutils netcat unzip && \  
apt-get -y autoremove && \  
apt-get clean  

