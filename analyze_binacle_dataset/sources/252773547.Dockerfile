FROM python:2-alpine  
MAINTAINER billypon  
  
ADD localtime /etc/localtime  
RUN pip install shadowsocks  
  
CMD ssserver -k $password -q  

