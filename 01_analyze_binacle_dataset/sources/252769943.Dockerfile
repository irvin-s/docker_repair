FROM nginx:latest  
MAINTAINER Arthur Burkart <artburkart@gmail.com>  
  
RUN rm /etc/nginx/conf.d/default.conf  
COPY sites-enabled/default /etc/nginx/conf.d/default.conf  
COPY run.sh /run.sh  
  
CMD ["/run.sh"]  

