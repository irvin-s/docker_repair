FROM alpine:3.3  
RUN apk --no-cache add nginx  
  
EXPOSE 80  
COPY nginx/nginx.conf /etc/nginx/nginx.conf  
COPY nginx/default.conf /etc/nginx/conf.d/default.conf  
COPY www /usr/share/nginx/html  
  
CMD ["nginx", "-g", "daemon off;"]  

