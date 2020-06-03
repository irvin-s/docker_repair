FROM node:8.2-alpine  
LABEL MAINTAINER Chris Mosetick <cmosetick@gmail.com>  
  
RUN \  
apk --no-cache --update add yarn dumb-init && \  
rm -rf /var/cache/apk/* /tmp && \  
mkdir /tmp && \  
chmod 777 /tmp  
  
ENV TEMP=/tmp  
  
ENTRYPOINT ["/usr/bin/dumb-init","--"]  
CMD ["/usr/local/bin/npm","start"]  

