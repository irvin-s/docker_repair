FROM alpine:3.7  
MAINTAINER billypon  
  
ADD aria2 /usr/bin  
ADD aria2.conf /etc  
  
RUN apk add --no-cache aria2 && \  
mkdir /data && \  
sleep 0  
  
WORKDIR /data  
VOLUME ["/data"]  
EXPOSE 6800  
CMD ["aria2"]  

