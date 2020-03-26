FROM nginx:stable-alpine  
  
RUN apk add --no-cache inotify-tools  
  
RUN mkdir /files  
ADD nginx.conf /etc/nginx/nginx.conf  
  
COPY launcher /usr/local/bin  
  
CMD ["launcher"]  

