FROM python:2.7-alpine  
  
WORKDIR /replication-couch  
COPY replicate.py /replication-couch/  
  
CMD [ "python", "./replicate.py" ]  

