FROM python:2.7.12-wheezy  
  
MAINTAINER Amajd Masad <amjad.masad@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y python-numpy python-scipy \  
python-matplotlib ipython ipython-notebook \  
python-pandas python-sympy python-nose  

