FROM node:6.10.3  
  
RUN apt-get update && \  
apt-get install -y libelf1 && \  
apt-get clean && \  
apt-get autoclean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

