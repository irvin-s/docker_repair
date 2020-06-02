FROM python:3-alpine3.7  
WORKDIR /app  
  
ADD requirements.txt ./  
RUN pip install -r requirements.txt  
ADD docker-entrypoint.sh gitlab-artifact-cleanup ./  
  
ENTRYPOINT [ "./docker-entrypoint.sh" ]  

