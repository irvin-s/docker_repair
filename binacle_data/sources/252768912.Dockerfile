FROM node:alpine  
  
RUN apk add --no-cache --virtual .build-deps \  
git  
  
RUN mkdir -p /var/www/  
  
WORKDIR /var/www/  
  
RUN git clone https://github.com/turtlecoin/turtlecoin-api-proxy.git . && \  
git checkout master  
  
#RUN sed -i "/var server = new TurtleCoinAPI()/{r docker.config  
# d}" service.js  
RUN yarn && \  
chown -R node:node /var/www  
  
RUN apk del .build-deps  
  
EXPOSE 80  
CMD ["node", "service.js"]

