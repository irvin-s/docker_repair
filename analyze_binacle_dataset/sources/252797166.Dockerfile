FROM ubuntu:xenial  
RUN apt-get update && apt-get -y install haproxy  
VOLUME /etc/haproxy  
EXPOSE 9000  
EXPOSE 9001  
ADD haproxy.cfg /etc/haproxy/  
CMD haproxy -f /etc/haproxy/haproxy.cfg -db  

