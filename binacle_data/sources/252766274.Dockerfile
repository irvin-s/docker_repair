FROM python:2-alpine  
  
COPY src/ /opt/arlo/  
WORKDIR /opt/arlo  
  
RUN pip install -r requirements.txt  
  
CMD /opt/arlo/run.sh  

