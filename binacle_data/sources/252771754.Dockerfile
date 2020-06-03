FROM alpine:latest  
  
RUN apk add --no-cache util-linux  
  
RUN mkdir /storage  
  
VOLUME /storage  
  
COPY echo-service.sh /bin/  
CMD /bin/echo-service.sh

