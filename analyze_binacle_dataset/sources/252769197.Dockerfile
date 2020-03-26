FROM ubuntu:latest  
  
#Autor  
MAINTAINER ÁNGEL VALERA MOTOS <angelvalera.epal@gmail.com>  
  
#Actualizar Sistema Base  
RUN sudo apt-get -y update  
  
#Descargar aplicacion  
RUN sudo apt-get install -y git  
RUN sudo git clone https://github.com/AngelValera/proyectoIV-Modulo-1.git  
  
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
RUN cd proyectoIV-Modulo-1/ && ls -l  
RUN cd proyectoIV-Modulo-1/ && cat requirements.txt  
RUN cd proyectoIV-Modulo-1/ && sudo pip install -r requirements.txt  
  
#Migraciones  
RUN cd proyectoIV-Modulo-1/ && python manage.py migrate --noinput  

