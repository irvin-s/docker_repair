FROM cultureamp/docker-ansible:latest  
MAINTAINER Cultureamp IS Team <is_team@cultureamp.com>  
  
ADD . /usr/src/app  
RUN pip install /usr/src/app  
WORKDIR /usr/src/app  

