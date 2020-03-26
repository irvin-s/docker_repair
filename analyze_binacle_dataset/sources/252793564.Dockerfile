FROM ubuntu:14.04  
RUN apt-get update &&\  
apt-get install -qy python python-dev python-pip libffi-dev libssl-dev  
ADD . /usr/src/app/  
WORKDIR /usr/src/app  
RUN pip install -r requirements.txt  
RUN python setup.py install  
EXPOSE 8000  

