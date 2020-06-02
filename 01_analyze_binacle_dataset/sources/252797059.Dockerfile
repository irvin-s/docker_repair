# cloudfleet radicale  
#  
# VERSION 0.1  
FROM debian  
  
COPY . /opt/cloudfleet/setup  
WORKDIR /opt/cloudfleet/setup  
  
RUN scripts/install.sh  
CMD scripts/start.sh  
  
EXPOSE 80  

