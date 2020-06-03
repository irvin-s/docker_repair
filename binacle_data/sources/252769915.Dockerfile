FROM alpine:3.7  
MAINTAINER homi  
  
RUN apk add --no-cache curl  
  
#set timezone  
RUN apk --update add tzdata && \  
cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \  
apk del tzdata && \  
rm -rf /var/cache/apk/*  
  
CMD ["cron"]  

