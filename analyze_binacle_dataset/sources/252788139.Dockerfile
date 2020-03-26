FROM node:10.3.0-alpine  
RUN apk add --update netcat-openbsd git && rm -rf /var/cache/apk/*  
CMD [ "node" ]  

