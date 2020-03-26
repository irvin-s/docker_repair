FROM python:alpine  
  
RUN pip install yamllint  
  
COPY docker-entrypoint.sh /usr/local/bin/  
  
WORKDIR /workdir  
ENTRYPOINT ["docker-entrypoint.sh"]  

