FROM python:2  
RUN apt-get update  
  
RUN apt-get install -y mapserver-bin  
RUN apt-get install -y lighttpd  
  
COPY lighttpd.conf /lighttpd.conf  
  
VOLUME /data  
  
CMD ["lighttpd", "-f", "/lighttpd.conf"]  
  

