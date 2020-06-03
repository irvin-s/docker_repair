FROM python:3.6-alpine  
  
RUN pip install 'mongo-connector[elastic2]'  
ADD entrypoint.sh /entrypoint.sh  
VOLUME /data  
  
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]  

