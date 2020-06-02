# DOCKER-VERSION 1.1.0  
FROM alpine:3.2  
MAINTAINER t.dettrick@uq.edu.au  
  
# Set defaults which should be overridden on run  
ENV SSL_DIR /opt/ssl  
ENV CONFIG_DIR /opt/dit4c-switchboard.d  
ENV DIT4C_DOMAIN dit4c.metadata.net  
  
RUN apk add --update curl docker && rm -rf /var/cache/apk/*  
  
ADD /opt /opt  
  
CMD ["sh", "/opt/run.sh"]  

