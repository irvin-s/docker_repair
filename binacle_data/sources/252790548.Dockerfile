# Version sistema operativo  
FROM ubuntu:17.10  
# Autor  
MAINTAINER Carlos Toledano Delgado <carliyostole@gmail.com>  
  
#Actualizar Repositorio  
RUN apt-get -y update  
  
#Instalamos python y pip por medio de nuestro Makefile  
RUN apt-get install -y python-dev  
RUN apt-get install -y libpq-dev  
RUN apt-get install -y python-pip  
RUN pip install --upgrade pip  
  
#Instalamos git y descargamos el repositorio  
RUN apt-get install -y git  
RUN git clone https://github.com/carlillostole/proyectoIV17-18  
  
# Instalacion de las dependencias del proyecto  
RUN cd proyectoIV17-18/ && make install  
  
EXPOSE 8000  
WORKDIR proyectoIV17-18/  
CMD gunicorn app:app --log-file=- --bind 0.0.0.0:8000  

