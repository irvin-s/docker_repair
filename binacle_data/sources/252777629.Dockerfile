FROM gliderlabs/alpine  
RUN apk --update add nodejs  
  
ADD node_modules.tar.gz /usr/src/app/  
ENTRYPOINT ["/usr/src/app/index.js"]  
CMD []  
ADD index.js /usr/src/app/index.js  

