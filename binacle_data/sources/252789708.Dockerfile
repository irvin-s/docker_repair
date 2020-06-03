FROM alpine:3.3  
MAINTAINER Raju Dawadi <rajudawadinp@gmail.com>  
  
RUN apk update  
  
RUN apk add nginx  
  
COPY index.html /usr/share/nginx/html/  
  
CMD ["nginx", "-g", "daemon off;"]  

