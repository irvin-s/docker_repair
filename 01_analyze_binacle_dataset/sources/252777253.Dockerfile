FROM ubuntu:latest  
  
#Autor  
MAINTAINER Cesar Albusac Jorge <cesypozo@gmail.com>  
  
#Actualizar Sistema Base  
RUN apt-get -y update  
  
  
#Instalar Python y mongodb  
RUN apt-get -y install mongodb  
  
RUN apt-get install -y python-setuptools  
RUN apt-get -y install python-dev  
RUN apt-get -y install supervisor  
RUN apt-get -y install build-essential  
RUN apt-get -y install python-psycopg2  
RUN apt-get -y install libpq-dev  
RUN apt-get -y install python-pip  
RUN pip install mlab  
RUN pip install --upgrade pip  
RUN pip install mlab  
  
RUN useradd -m docker && echo "docker:docker"  
  
USER docker  
CMD /bin/bash  
  

