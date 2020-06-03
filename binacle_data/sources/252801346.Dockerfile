FROM python:alpine  
  
ENV CURATOR_VERSION 5.4.1  
ENV DELAY_SECOND=3600  
RUN pip install -U --quiet elasticsearch-curator==$CURATOR_VERSION  
  
COPY docker-entrypoint.sh /docker-entrypoint.sh  
  
RUN ["chmod", "+x", "/docker-entrypoint.sh"]  
  
CMD ["/docker-entrypoint.sh"]

