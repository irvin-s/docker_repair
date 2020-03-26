FROM node:alpine  
RUN apk add --no-cache python \  
&& npm install -g --unsafe shadowsocks-manager \  
&& npm cache clear -f  
VOLUME /root/.ssmgr  
ENTRYPOINT ["/usr/local/bin/ssmgr"]  

