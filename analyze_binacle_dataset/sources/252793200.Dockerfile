FROM alpine:edge  
  
ENV PACKAGES bash mongodb  
ENV TERM=linux  
  
RUN apk update && apk upgrade && \  
apk add $PACKAGES \--no-cache && \  
rm -rf /var/cache/apk/*  
  
RUN mkdir -p /data/db && \  
chown -R mongodb /data/db  
  
EXPOSE 27017  
CMD mongod  

