FROM alpine:3.7  
RUN apk update && \  
apk add yarn 'nodejs>8' 'nodejs<9' && \  
rm -rf /var/cache/apk/*  
  
ADD . /app  
WORKDIR /app  
RUN yarn install && \  
npm run build:production  
  
CMD [ "sh", "-c", "npm run server $TARGET_DIR" ]  
  
EXPOSE 3000  

