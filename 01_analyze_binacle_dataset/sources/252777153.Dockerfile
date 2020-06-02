FROM gliderlabs/alpine:3.1  
MAINTAINER CenturyLink Labs <clt-labs-futuretech@centurylink.com>  
  
RUN apk-install redis  
EXPOSE 6379  
CMD [ "redis-server" ]  

