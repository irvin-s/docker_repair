# Version 1.0.0  
# cyan.img.Nginx  
#========== Basic Image ==========  
From nginx:1.9.11  
MAINTAINER "DreamInSun"  
#========== Expose ==========  
ENV NGINX_HOME /etc/nginx  
  
#========== Expose ==========  
ADD nginx $NGINX_HOME  
  
#========== Expose ==========  
#EXPOSE 80  
#EXPOSE 443  
#========== Expose ==========  
VOLUME $NGINX_HOME/sites-enabled  
VOLUME $NGINX_HOME/ssl  
VOLUME $NGINX_HOME/html  
VOLUME $NGINX_HOME/conf.d  
VOLUME $NGINX_HOME/log  
  
#========= Add Entry Point ==========  
ADD shell /shell  
RUN chmod a+x /shell/*  
  
#========= Start Service ==========  
ENTRYPOINT ["/shell/docker-entrypoint.sh"]  
CMD ["nginx","-g","daemon off;"]  

