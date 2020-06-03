FROM python:3.5  
MAINTAINER juliansalas080@gmail.com  
  
  
#Enviroment variables  
ENV USER=desarrollo  
ENV HOME_DIR=home/desarrollo  
ENV SHELL=/bin/bash  
  
# Install packages necesary  
RUN pip install --upgrade pip  
RUN mkdir /tmp/requirements  
COPY requirements.txt /tmp/requirements  
RUN pip install -r /tmp/requirements/requirements.txt  
ADD ./flasky /$HOME_DIR  
  
#coments  
#set up user not root  
RUN useradd -ms $SHELL $USER  
RUN mkdir -p /$HOME_DIR  
RUN chown -R $USER:$USER /$HOME_DIR  
  
USER $USER  
WORKDIR /$HOME_DIR  
  

