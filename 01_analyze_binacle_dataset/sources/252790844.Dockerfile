FROM alpine  
MAINTAINER cuigh <noname@live.com>  
  
COPY ./start /  
RUN apk --update add socat && \  
rm -rf /var/cache/apk/* && \  
rm -rf /root/.cache  
  
ENTRYPOINT ["/start"]

