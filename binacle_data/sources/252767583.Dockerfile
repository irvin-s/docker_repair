FROM ubuntu:latest  
MAINTAINER Alejandro Casado Quijada <acasadoquijada@gmail.com>  
  
RUN apt-get -y update  
RUN apt-get -y install python-setuptools  
RUN apt-get -y install python-dev  
RUN apt-get -y install python-pip  
RUN apt-get -y install supervisor  
RUN pip install mlab  
  
RUN useradd -m docker && echo "docker:docker"  
  
USER docker  
CMD /bin/bash  

