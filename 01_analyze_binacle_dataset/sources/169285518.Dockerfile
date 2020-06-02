#Evenge - gestor de eventos (events management)
#Copyright (C) 2014 - desarrollo.evenge@gmail.com
#Carlos Campos Fuentes | Francisco Javier Expósito Cruz | Iván Ortega Alba | Victor Coronas Lara
#
#This program is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
################################################################

FROM ubuntu:latest
MAINTAINER Evenge <desarrollo.evenge@gmail.com>

#Instala dependencias de python
RUN apt-get update && apt-get install -y python
RUN apt-get install -y python-setuptools
RUN easy_install pip
RUN apt-get install -y python-dev build-essential

#Instala frameworks
RUN pip install webapp2
RUN pip install jinja2

# Instala wget para descarga
RUN apt-get install -y wget

# Descargamos el sdk de Google App Engine
RUN wget https://storage.googleapis.com/appengine-sdks/featured/google_appengine_1.9.17.zip --no-check-certificate

# Instalamos zip
RUN apt-get install -y zip

# Descomprimimos el fichero descargado, ya tendremos disponible el SDK
RUN unzip google_appengine_1.9.17.zip

#Instalamos el google-cloud-sdk y configuramos el proyecto Evenge
# RUN curl -sSL https://sdk.cloud.google.com | bash
# RUN gcloud auth login
# RUN gcloud config set project <google-cloud-project-id>

# Instalamos git y clonamos el repositorio de Evenge
RUN apt-get install -y git
RUN git clone https://github.com/evenge/EVENGE.git
RUN cd EVENGE && git branch -b $USER

#La integración continua corre de la mano de GAE, donde el SDK nos permite despliegue y pruebas en local
