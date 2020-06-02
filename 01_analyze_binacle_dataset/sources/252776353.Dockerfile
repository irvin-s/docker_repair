FROM ubuntu:17.10  
  
RUN apt-get update && apt-get upgrade -y  
RUN apt-get install -y cifs-utils rsync  
RUN apt-get clean  

