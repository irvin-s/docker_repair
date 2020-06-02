FROM alpine:latest  
  
# Install nginx  
RUN apk add --update nginx  
  
# Copy the files required to run  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
ONBUILD ENTRYPOINT ["nginx", "-g", "pid /tmp/nginx.pid; daemon off;"]  

