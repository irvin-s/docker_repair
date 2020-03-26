FROM httpd:latest  
MAINTAINER Christopher Petty <Docker@chriswastaken.com>  
  
ENV DEBIAN_FRONTEND interactive  
ENV ServerName server.localhost.local  
ENV LC_ALL C  
  
RUN apt-get update && apt-get install -y \  
git  
  
# Copy up the resources  
ENV HTTPD_HTDOCS $HTTPD_PREFIX/htdocs  
ENV HTTPD_CONF_DIR $HTTPD_PREFIX/conf  
  
RUN rm -f $HTTPD_HTDOCS/index.html && \  
chgrp -R www-data $HTTPD_HTDOCS  
  
# Pull project  
COPY ./data/* $HTTPD_PREFIX/htdocs/  
  
# Open port 80  
EXPOSE 80  

