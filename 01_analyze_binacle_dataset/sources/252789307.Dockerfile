FROM alpine:3.1  
MAINTAINER alex <alexwhen@gmail.com>  
  
RUN apk --update add nginx && mkdir /tmp/nginx && rm -rf /var/cache/apk/*  
  
COPY starter /usr/html  
  
EXPOSE 80  
CMD ["nginx", "-g", "daemon off;"]  

