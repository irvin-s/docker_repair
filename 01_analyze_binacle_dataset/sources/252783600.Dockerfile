FROM alpine:latest  
RUN mkdir /data  
VOLUME /data  
RUN apk add --no-cache nodejs  
ENTRYPOINT ["nodejs"]  

