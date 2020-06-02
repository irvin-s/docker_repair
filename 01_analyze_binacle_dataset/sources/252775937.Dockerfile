FROM ubuntu:14.04  
MAINTAINER Brandon Mangold "<bmangold@docker.com>"  
RUN apt-get update && apt-get install -y \  
python-pip python-dev git \  
libffi-dev libyaml-dev libssl-dev \  
htop nethogs  
  
COPY requirements.txt /test/  
RUN pip install -r /test/requirements.txt  
WORKDIR /test  
  

