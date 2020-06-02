FROM python:2.7.13-slim  
MAINTAINER Chad Peterson <chapeter@cisco.com>  
  
  
  
RUN apt-get -y update && apt-get -y upgrade  
RUN apt-get -y install ansible  
RUN apt-get -y install vim  
  
COPY . /opt/acibootstrap  
  
WORKDIR /opt/acibootstrap  
  
RUN pip install -r requirements.txt  
  
EXPOSE 5000  
EXPOSE 5001  
EXPOSE 8001  
  
CMD ./webstartup.sh  

