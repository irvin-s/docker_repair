FROM ubuntu:16.04  
MAINTAINER ainokila  
  
# Configuracion del entorno  
RUN apt-get update  
RUN apt-get install -y python-setuptools  
RUN apt-get install -y python-dev  
RUN apt-get install -y build-essential  
RUN apt-get install -y libpq-dev  
RUN apt-get install -y python-pip  
RUN apt-get install -y python3  
RUN apt-get install -y python3-pip  
RUN pip install --upgrade  
RUN apt-get install net-tools  
  
# Instalación  
RUN apt-get install -y git  
RUN git clone https://github.com/ainokila/ProyectoIV  
# Instalación de las dependecncias del proyecto  
RUN pip3 install -r ProyectoIV/requirements.txt  
EXPOSE 80  
CMD cd ProyectoIV && python3 app.py  

