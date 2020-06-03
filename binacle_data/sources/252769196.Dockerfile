FROM ubuntu:latest  
  
#Autor  
MAINTAINER ÁNGEL VALERA MOTOS <angelvalera.epal@gmail.com>  
  
#Actualizar Sistema Base  
RUN sudo apt-get -y update  
  
#Descargar aplicacion  
RUN sudo apt-get install -y git  
RUN sudo git clone https://github.com/AngelValera/bares-y-tapas-DAI  
  
# Instalar Python y PostgreSQL  
RUN sudo apt-get install -y python-setuptools  
RUN sudo apt-get -y install python-dev  
RUN sudo apt-get -y install build-essential  
RUN sudo apt-get -y install python-psycopg2  
RUN sudo apt-get -y install libpq-dev  
RUN sudo easy_install pip  
RUN sudo pip install --upgrade pip  
  
#Instalar la app  
RUN ls  
RUN cd bares-y-tapas-DAI/ && ls -l  
RUN cd bares-y-tapas-DAI/ && cat requirements.txt  
RUN cd bares-y-tapas-DAI/ && sudo pip install -r requirements.txt  
  
#Migraciones  
RUN cd bares-y-tapas-DAI/ && python populate_app.py  
RUN cd bares-y-tapas-DAI/ && python manage.py migrate --noinput  

