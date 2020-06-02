FROM python:2.7  
MAINTAINER Alejandro Barrera <alejandro.barrera@duke.edu>  
  
# Install python and MACS2 from pip  
ENV MACS2_VERSION 2.1.0.20151222  
RUN pip install numpy  
RUN pip install MACS2==${MACS2_VERSION}  
  
# Default command to execute at startup of the container  
CMD ["macs2"]  

