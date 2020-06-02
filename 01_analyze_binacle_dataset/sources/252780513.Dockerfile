FROM node:boron  
  
RUN apt-get update \  
&& apt-get install -y python-pip libpython-dev \  
&& pip install awscli \  
&& apt-get clean  

