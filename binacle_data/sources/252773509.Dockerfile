FROM nginx  
  
MAINTAINER Bill Lee "bill.lee.y@gmail.com"  
COPY nginx.conf /etc/nginx/conf.d/default.conf  
  
VOLUME ["/opt/angular"]  

