# DOCKER-VERSION 1.1.0  
FROM alpine:edge  
MAINTAINER t.dettrick@uq.edu.au  
  
# Set defaults which should be overridden on run  
ENV PORTAL_URL https://example.test  
  
RUN echo $(cat /etc/apk/repositories) | sed -e 's/main/community/' \  
>> /etc/apk/repositories && \  
apk add --update docker jq  
  
ADD /opt /opt  
  
CMD ["sh", "/opt/run.sh"]  

