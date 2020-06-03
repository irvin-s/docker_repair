# TODO: It is NOT neccessary to use node in a production image  
# The build process should be moved to earlier stage  
FROM node:8.4.0-alpine  
  
# INSTALL nginx  
RUN apk update && apk add --no-cache nginx  
  
# BUILD STOLLEN  
RUN mkdir -p /stollen/src  
COPY . /stollen/src  
RUN cd /stollen/src &&\  
npm install &&\  
npm run prod &&\  
mkdir -p /usr/share/nginx/html &&\  
cp -r /stollen/src/dist/* /usr/share/nginx/html &&\  
rm -rf /stollen  
  
# CONFIG NGINX  
COPY nginx.conf /etc/nginx/nginx.conf  
RUN mkdir -p /run/nginx &&\  
touch /run/nginx/nginx.pid  
  
COPY config_backend.sh ./  
  
# START NGINX SERVICE  
CMD ["./config_backend.sh", "/usr/share/nginx/html"]  

