FROM php:7.1.9-alpine  
  
RUN apk --no-cache update && \  
apk upgrade  
RUN apk add bash  
  
ADD healthcheck.sh /opt/capside/healthcheck.sh  
RUN chmod 755 /opt/capside/healthcheck.sh  
  
HEALTHCHECK \--interval=30s \--timeout=30s CMD /opt/capside/healthcheck.sh  

