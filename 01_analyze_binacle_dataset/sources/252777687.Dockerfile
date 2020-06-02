FROM ubuntu:14.04  
MAINTAINER Antonio Manuel Fernández Cantos <antkk10@correo.ugr.es>  
  
# Variables de entorno para poder conectarse a la base de datos  
ARG DATABASE_URL  
ARG HOST_BD  
ARG NAME_BD  
ARG PW_BD  
ARG TOKENBOT  
ARG USER_BD  
  
ENV DATABASE_URL=$DATABASE_URL  
ENV HOST_BD=$HOST_BD  
ENV NAME_BD=$NAME_BD  
ENV PW_BD=$PW_BD  
ENV TOKENBOT=$TOKENBOT  
ENV USER_BD=$USER_BD  
  
RUN apt-get update  
  
# Instalamos python  
RUN apt-get install -y python-setuptools  
RUN apt-get install -y python-dev  
RUN apt-get install -y build-essential  
RUN apt-get install -y python-psycopg2  
RUN apt-get install -y libpq-dev  
RUN apt-get install -y python-pip  
RUN pip install --upgrade pip  
  
# Instalamos git y descargamos el repositorio  
RUN apt-get install -y git  
RUN git clone https://github.com/Antkk10/BotTelegramInfoActividadesUGR.git  
  
# Instalamos todo lo necesario para ejecutar el bot  
RUN cd BotTelegramInfoActividadesUGR/ && make install  

