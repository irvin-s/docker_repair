FROM python:2.7-alpine  
  
COPY . /mattermost-giphy  
WORKDIR /mattermost-giphy  
  
RUN python setup.py install  
  
EXPOSE 5000  
ENTRYPOINT ["python", "run.py"]  

