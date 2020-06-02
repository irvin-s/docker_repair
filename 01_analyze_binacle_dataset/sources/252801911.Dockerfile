#Version de Ubuntu que queremos en la imagen  
FROM ubuntu:latest  
  
#Encargado del mantenimiento  
MAINTAINER Eduardo Sanchez Sanchez <edu_gr87@hotmail.com>  
  
#Actualizamos repositorio  
RUN apt-get update  
  
#Instalamos git y descargamos el repositorio  
RUN apt-get -y install git  
RUN git clone https://github.com/edugr87/proyecto-iv.git  
  
#Instalamos python y pip por medio de nuestro Makefile  
RUN apt-get install -y python-dev  
RUN apt-get install -y libpq-dev  
RUN apt-get install -y python-pip  
RUN pip install --upgrade pip  
  
#Instalamos los requisitos de nuestra aplicacion  
RUN cd proyecto-iv && pip install -r requirements.txt  
  
#Creamos la base de datos  
RUN cd proyecto-iv && python manage.py makemigrations  
RUN cd proyecto-iv && python manage.py migrate  

