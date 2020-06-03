  
FROM alpine:latest  
  
MAINTAINER dima <dimabudescu@gmail.com>  
  
RUN apk --update add nginx  
  
COPY index.html /usr/share/nginx/html  
  
EXPOSE 8080  
CMD ["nginx", "-g", "daemon off;"]  

