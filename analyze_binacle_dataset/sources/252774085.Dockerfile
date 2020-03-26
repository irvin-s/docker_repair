FROM debian:stretch  
  
RUN apt-get update  
  
RUN apt-get install -y wget unzip  
  
COPY scripts/common/ /scripts/  
COPY scripts/lite/ /scripts/  
  
WORKDIR /root  
  
RUN /scripts/import  

