FROM resin/armhf-alpine:edge  
RUN [ "cross-build-start" ]  
RUN apk --update add bash git python build-base nodejs nodejs-npm  
RUN [ "cross-build-end" ]  

