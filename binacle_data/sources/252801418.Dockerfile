FROM node:9.4.0-alpine  
  
RUN apk add --update sudo \  
&& sudo npm install ilsap -g --unsafe-perm \  
&& rm -rf /var/cache/apk/*  
  
EXPOSE 8997  
CMD ilsap  

