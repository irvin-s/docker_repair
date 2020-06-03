FROM node:alpine  
  
RUN apk add \--no-cache python firefox-esr \  
&& apk add \--no-cache \--virtual .build-deps py-pip \  
&& pip install awscli \  
&& apk del .build-deps  

