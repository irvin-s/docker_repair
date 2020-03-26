FROM nginx  
  
MAINTAINER "Ivan Ermilov <mailto:ivan.s.ermilov@gmail.com>"  
COPY default.conf /etc/nginx/conf.d/default.conf  
COPY css /data/bde-css  

