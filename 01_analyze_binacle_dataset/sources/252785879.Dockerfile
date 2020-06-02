FROM node:8.4.0-alpine  
  
RUN apk add --no-cache openssl unzip  
  
COPY entrypoint.sh /usr/local/bin  
RUN ln -s usr/local/bin/entrypoint.sh  
ENTRYPOINT ["entrypoint.sh"]

