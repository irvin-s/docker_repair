FROM ubuntu:14.04  
MAINTAINER Alejandro Casado Quijada <acasadoquijada@gmail.com>  
  
#Instalamos git  
RUN sudo apt-get -y update  
RUN sudo apt-get install -y git  
  
#Clonamos el repositorio  
RUN sudo git clone https://github.com/acasadoquijada/IV.git  
  
#Instalamos las herramientas de python3 necesarias  
RUN sudo apt-get install -y python3-setuptools  
RUN sudo apt-get -y install python3-dev  
RUN sudo apt-get -y install build-essential  
RUN sudo apt-get -y install python-psycopg2  
RUN sudo apt-get -y install libpq-dev  
RUN sudo easy_install3 pip  
RUN sudo pip install --upgrade pip  
  
#Instalamos los requerimientos necesarios  
RUN cd IV/ && make install  
  
#Realizamos la sincronizacion entre las BD  
RUN cd IV/ && python3 manage.py syncdb --noinput  

