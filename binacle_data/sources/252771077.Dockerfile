FROM node:9-alpine  
LABEL maintainer="Ahmad Nassri <ahmad@ahmadnassri.com>"  
  
WORKDIR /usr/src/app/  
  
COPY . ./  
  
# install dependencies  
RUN apk add --no-cache --virtual .run-deps grep && npm install --production  
  
RUN adduser -u 9000 -S -s /bin/false app  
USER app  
  
VOLUME /code  
WORKDIR /code  
  
CMD ["/usr/src/app/bin.js"]  

