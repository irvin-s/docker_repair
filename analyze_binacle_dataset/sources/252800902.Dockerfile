FROM ubuntu  
LABEL maintainer="Douglas Eduardo Rosa douglas.erosa@gmail.com"  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get install -y make  
RUN apt-get install -y gcc  
RUN apt-get install -y g++  
RUN apt-get install -y gfortran  
RUN apt-get install -y mpich  
RUN apt-get install -y vim  
  
ADD NPB3.3.1 /NPB3.3.1  
  
RUN apt-get autoremove  
RUN apt-get clean  

