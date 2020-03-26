FROM golang  
  
LABEL maintainer "grigory.aksentiev@gmail.com"  
  
RUN apt update  
RUN apt install -y golang-glide  
RUN apt clean  

