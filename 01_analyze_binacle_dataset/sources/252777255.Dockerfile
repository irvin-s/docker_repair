FROM ubuntu:latest  
  
#Autor  
MAINTAINER Cesar Albusac Jorge <cesypozo@gmail.com>  
  
#Actualizar Sistema Base  
RUN apt-get -y update  
  
#Descargar aplicacion  
RUN apt-get install -y git  
RUN git clone https://github.com/cesar2/Tripbot.git  
  
#Instalar Python y mongodb  
RUN apt-get -y install mongodb  
  
RUN apt-get install -y python-setuptools  
RUN apt-get -y install python-dev  
RUN apt-get -y install build-essential  
RUN apt-get -y install python-psycopg2  
RUN apt-get -y install libpq-dev  
RUN easy_install pip  
RUN pip install --upgrade pip  
  

