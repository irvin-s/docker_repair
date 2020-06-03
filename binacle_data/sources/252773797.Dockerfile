FROM ubuntu:16.04  
  
RUN apt-get update  
RUN apt-get install -yq python3-pip python3-numpy  
RUN apt-get install -yq less sudo octave  
RUN apt-get clean  
  
RUN pip3 install invoke  

