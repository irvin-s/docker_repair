FROM python:3.5  
MAINTAINER Maxime Delorme <maxime.delorme@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y gcc openmpi-bin openmpi-common libopenmpi-dev  
RUN apt-get install -y imagemagick  
RUN pip install matplotlib scipy  
COPY build.sh /project/build  
  

