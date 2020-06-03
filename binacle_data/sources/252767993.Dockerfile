FROM alpine:3.4  
MAINTAINER "Adam Dodman <adam.dodman@gmx.com>"  
RUN apk add --no-cache python py-pip \  
&& pip install --upgrade pip \  
&& pip install paho-mqtt scapy configparser \  
&& mkdir dash  
  
ADD main.py /dash/main.py  
  
CMD ["python","/dash/main.py","-c","/config"]  

