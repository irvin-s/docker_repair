FROM python:2.7-alpine  
  
MAINTAINER Dan Streeter <dan@danstreeter.co.uk>  
  
COPY . /mattermost-insult  
WORKDIR /mattermost-insult  
  
RUN python setup.py install  
  
ENTRYPOINT ["python", "run.py"]  

