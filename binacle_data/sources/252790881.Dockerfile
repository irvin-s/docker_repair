FROM cultureamp/docker-python:latest  
MAINTAINER Infrastructure Services Team <is_team@cultureamp.com>  
  
RUN apt-get update && apt-get install rsync  
  
RUN pip install --no-cache-dir boto \  
awscli \  
troposphere \  
awacs \  
ansible==2.2.0.0  
  
WORKDIR /usr/src/app  

