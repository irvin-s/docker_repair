FROM nginx:1.12  
MAINTAINER Wessel Pieterse <wessel<at>ordercloud<dot>co<dot>za>  
  
ADD ./nginx.conf /etc/nginx/nginx.conf  
ADD ./default.conf /etc/nginx/conf.d/default.conf  

