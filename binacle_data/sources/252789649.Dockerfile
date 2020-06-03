FROM alpine:latest  
LABEL maintainer "dutradda@gmail.com"  
  
RUN apk add --update \  
ices && \  
rm -rf /var/cache/apk/*  
  
COPY ices.xml /etc/ices.xml  
  
COPY docker-entrypoint.sh /entrypoint.sh  
  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ices /etc/ices.xml  

