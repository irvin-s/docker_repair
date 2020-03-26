# DOCKER-VERSION 1.1.0  
FROM alpine:3.2  
MAINTAINER t.dettrick@uq.edu.au  
  
# Set defaults which should be overridden on run  
ENV SSL_DIR /opt/ssl  
ENV CONFIG_DIR /opt/config  
ENV ETCD_VERSION v2.2.0  
ENV SERVICE_DISCOVERY_PATH /dit4c/containers  
  
RUN apk add --update curl docker && rm -rf /var/cache/apk/*  
  
ADD /opt /opt  
  
CMD ["sh", "/opt/run.sh"]  

