FROM nginx:1.11.7-alpine  
MAINTAINER aimakun "test@example.com"  
COPY nginx.conf /etc/nginx/nginx.conf  
  
EXPOSE 80 443  
CMD ["nginx", "-g", "daemon off;"]

