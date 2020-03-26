FROM mhart/alpine-node:6  
RUN apk add --no-cache git  
RUN npm install -g node-gyp gatsby@1.0.0-alpha12-alpha.d7d6ef64  
  
ENV LC_ALL=C.UTF-8 \  
LANG=en_US.UTF-8 \  
LANGUAGE=en_US.UTF-8  
WORKDIR /srv  
VOLUME /srv  
  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

