FROM debian:sid  
  
RUN apt-get update  
RUN apt-get install software-properties-common -y  
RUN apt-get install wget -y  
RUN apt-get install sortmerna=2.1-2 -y  
  
WORKDIR /data  
  
ENTRYPOINT ["/usr/bin/sortmerna"]  

