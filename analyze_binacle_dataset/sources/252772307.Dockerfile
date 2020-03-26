FROM iron/python:2.7.11-dev  
  
WORKDIR /app  
ADD . /app  
  
RUN apk add --update py-requests  
  
CMD ["python", "harvest_backup.py"]  

