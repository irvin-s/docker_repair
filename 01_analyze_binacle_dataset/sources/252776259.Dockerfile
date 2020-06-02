############################################################  
# Dockerfile to build Nginx Installed Containers  
# Based on alpine  
############################################################  
  
  
# Set the base image to Alpine  
FROM alpine:3.2  
  
# File Author / Maintainer  
MAINTAINER Karthik Gaekwad  
  
# Install Nginx  
RUN apk add --update nginx && rm -rf /var/cache/apk/*  
RUN mkdir -p /tmp/nginx/client-body  
  
COPY nginx/nginx.conf /etc/nginx/nginx.conf  
COPY nginx/default.conf /etc/nginx/conf.d/default.conf  
COPY website /usr/share/nginx/html  
  
# Expose ports  
EXPOSE 80  
  
# Set the default command to execute  
# when creating a new container  
CMD ["nginx", "-g", "daemon off;"]

