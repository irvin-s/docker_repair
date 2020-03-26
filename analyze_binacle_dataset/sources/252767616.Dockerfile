FROM ubuntu:latest  
# MAINTAINER Hyon S Chu <hyon.s.chu@accenture.com>  
CMD echo Installing Accenture Tech Labs Scientific Python Enviro  
  
RUN apt-get install python -y  
RUN apt-get update && apt-get upgrade -y  
RUN apt-get install curl -y  
RUN curl -O https://bootstrap.pypa.io/get-pip.py  
RUN python get-pip.py  
RUN rm get-pip.py  
RUN echo "export PATH=~/.local/bin:$PATH" >> ~/.bashrc  
RUN apt-get install python-setuptools build-essential python-dev -y  
RUN apt-get install gfortran swig -y  
RUN apt-get install libatlas-dev liblapack-dev -y  
RUN apt-get install libfreetype6 libfreetype6-dev -y  
RUN apt-get install libxft-dev -y  
RUN apt-get install libxml2-dev libxslt-dev zlib1g-dev  
RUN apt-get install python-numpy  
  
ADD requirements.txt /tmp/requirements.txt  
RUN pip install -r /tmp/requirements.txt -q  

