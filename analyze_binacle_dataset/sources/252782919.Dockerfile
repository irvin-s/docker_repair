FROM node:6  
  
# Upgrade yarn  
RUN npm install --global yarn@1.3.2  
  
# Install AWS CLI tools  
RUN apt-get update \  
&& apt-get install -y python-dev python-pip \  
&& pip install --upgrade awscli \  
&& apt-get remove -y python-dev python-pip  

