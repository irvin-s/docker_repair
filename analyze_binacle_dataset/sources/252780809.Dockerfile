FROM badoque/alpine-nginx:latest  
  
ADD nginx.conf /etc/nginx/nginx.conf  
  
CMD ["nginx", "-g", "daemon off; error_log stderr info;"]

