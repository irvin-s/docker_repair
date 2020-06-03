FROM python:latest  
MAINTAINER cowpanda<ynw506@gmail.com>  
RUN pip install mongo-connector  
RUN pip install 'mongo-connector[elastic5]'  
WORKDIR /data  
CMD ["mongo-connector"]  
  

