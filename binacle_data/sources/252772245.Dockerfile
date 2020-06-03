FROM ubuntu  
MAINTAINER Alexander Vaniashev  
  
RUN dpkg --add-architecture i386  
RUN apt-get update  
RUN apt-get install wine  

