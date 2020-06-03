FROM alpine:3.6  
WORKDIR /usr/src/app  
  
RUN apk add --update nodejs \  
&& apk add --virtual build-dependencies nodejs-npm git \  
&& git clone https://github.com/napcs/node-livereload.git . \  
&& npm install \  
&& apk del build-dependencies \  
&& rm -rf /tmp/* /var/cache/apk/*  
  
ENTRYPOINT ["node", "bin/livereload.js"]  
CMD ["/usr/src/livereload-watch -u true -d"]  

