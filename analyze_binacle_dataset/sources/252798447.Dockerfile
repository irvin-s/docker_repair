FROM nginx:1.9.7  
MAINTAINER Danniel Magno <dennyloko@gmail.com>  
  
ADD default.conf /etc/nginx/conf.d/default.conf  
  
CMD ["nginx", "-g", "daemon off;"]  

