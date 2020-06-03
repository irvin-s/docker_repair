# Ubuntu server for host Django Apps  
FROM ubuntu:16.04  
MAINTAINER Bruno Soares <brunomsss@gmail.com>  
  
# install packages  
RUN apt-get update && apt-get install -y python3 python3-pip libpq-dev  
  
# update pip  
RUN /usr/bin/pip3 install --upgrade pip  
  
# prepare project path  
RUN mkdir /code  
WORKDIR /code  
  
# install project requirements  
ADD requirements.txt /code/  
RUN /usr/bin/pip3 install -r requirements.txt  
  
# copy project files to container  
ADD . /code/  
  
# execute webserver  
CMD gunicorn -b 0.0.0.0:8000 --workers 2 honrar_seguros.wsgi:application  

