FROM node:8-alpine  
  
  
RUN apk update \  
&& apk add jq curl \  
&& rm -rf /var/cache/apk/* \  
&& mkdir /data \  
&& npm install -g http-server  
  
ADD docker-entrypoint.sh /  
  
WORKDIR /data  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  

