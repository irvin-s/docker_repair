FROM ubuntu:latest  
  
RUN apt-get update && apt-get upgrade -y  
RUN apt-get -y install python-pip  
RUN apt-get install python-dev postgresql-server-dev-all -y  
  
RUN mkdir /code && cd /code  
WORKDIR /code  
ADD docker_links /code  
  
RUN pip install -r requirements.txt  

