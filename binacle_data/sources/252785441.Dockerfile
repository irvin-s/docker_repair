FROM ubuntu:latest  
  
RUN apt-get update \  
&& apt-get install --assume-yes \  
curl \  
git \  
python-dev \  
python-pip  
  
ADD examples/reforge /usr/local/sbin/reforge  
RUN chmod +x /usr/local/sbin/reforge  
  
WORKDIR /data  
  
ENTRYPOINT reforge  

