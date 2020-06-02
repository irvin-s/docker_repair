FROM node:9.11.1-alpine  
  
RUN apk update && \  
apk add --update gcc g++ make libc6-compat && \  
rm -rf /var/cache/apk/*  
  
RUN npm install --global gatsby --no-optional gatsby@1.9  
  
RUN mkdir -p /app  
WORKDIR /app  
VOLUME /app  
  
EXPOSE 8000  
COPY ./start.sh /  
RUN chmod +x /start.sh  
  
ENTRYPOINT ["/start.sh"]  
  

