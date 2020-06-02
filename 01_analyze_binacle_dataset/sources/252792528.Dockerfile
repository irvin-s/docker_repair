FROM python:3.5  
MAINTAINER danichispa <danichispa@gmail.com>  
  
RUN apt-get update && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
VOLUME /conf  
  
RUN git clone https://github.com/home-assistant/appdaemon.git .  
  
EXPOSE 5050  
RUN pip3 install .  
RUN pip3 install paho-mqtt  
  
CMD [ "appdaemon", "-c", "/conf" ]  

