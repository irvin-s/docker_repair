FROM alpine  
  
MAINTAINER cd "cleardevice@gmail.com"  
RUN apk add curl jq php php-json rsync --no-cache && \  
mkdir /data  
  
WORKDIR /data  
  
CMD ["sh", "-c", "while true; do sleep 5; done"]  

