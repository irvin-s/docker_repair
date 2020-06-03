FROM python:3.6-slim  
  
RUN pip install pyyaml requests  
  
RUN apt-get update && apt-get install -y git  
  
ADD assets/ /opt/resource/  
  
RUN chmod +x /opt/resource/*  

