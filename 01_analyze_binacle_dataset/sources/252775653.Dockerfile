FROM nginx  
MAINTAINER Marc Tanis "marc@blendimc.com"  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY site.conf /etc/nginx/conf.d/default.conf  
  
EXPOSE 80  

