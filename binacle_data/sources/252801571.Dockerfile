FROM python:latest  
MAINTAINER Fabio Sussarellu (sussarellu.fabio@gmail.com)  
ADD . /webapp  
WORKDIR /webapp  
CMD ["./start.sh"]  

