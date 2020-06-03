FROM python:3.5.2  
  
MAINTAINER Amajd Masad <amjad.masad@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y python-numpy python-scipy \  
python-matplotlib python-pandas python-sympy  

