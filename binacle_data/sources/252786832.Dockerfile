FROM python:3  
MAINTAINER Stefan Schindler  
  
RUN apt-get update  
RUN apt-get install -y libenchant1c2a  
  
RUN useradd -m -d /home/sopel sopel  
WORKDIR /home/sopel  
  
RUN pip install git+https://github.com/sopel-irc/sopel.git  
  
VOLUME /home/sopel/.sopel  
  
USER sopel  
CMD sopel  

