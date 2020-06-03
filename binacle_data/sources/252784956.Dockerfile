FROM node:8-alpine  
MAINTAINER butlerx <butlerx@notthe.cloud>  
WORKDIR /usr/src/app  
RUN apk add --update git build-base python && \  
mkdir -p /usr/src/app /usr/src/cp-translations  
COPY docker-entrypoint.sh /usr/src  
VOLUME /usr/src/app /usr/src/cp-translations  
EXPOSE 8080  
CMD ["/usr/src/docker-entrypoint.sh"]  

