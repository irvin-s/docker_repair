# Redirector Dockerfile Config  
FROM ubuntu:14.04  
MAINTAINER Kerry Knopp <kerry@codekoalas.com>  
  
RUN apt-get update && apt-get install -y apache2  
  
# let's copy a few of the settings from /etc/init.d/apache2  
ENV APACHE_CONFDIR /etc/apache2  
ENV APACHE_ENVVARS $APACHE_CONFDIR/envvars  
  
# and then a few more from $APACHE_CONFDIR/envvars itself  
ENV APACHE_RUN_USER www-data  
ENV APACHE_RUN_GROUP www-data  
ENV APACHE_RUN_DIR /var/run/apache2  
ENV APACHE_PID_FILE $APACHE_RUN_DIR/apache2.pid  
ENV APACHE_LOCK_DIR /var/lock/apache2  
ENV APACHE_LOG_DIR /var/log/apache2  
ENV APACHE_LOG_DIR /etc/apache2/sites-enabled  
ENV LANG C  
  
# ...  
RUN mkdir -p $APACHE_RUN_DIR $APACHE_LOCK_DIR $APACHE_LOG_DIR  
# make CustomLog (access log) go to stdout instead of files  
# and ErrorLog to stderr  
RUN find "$APACHE_CONFDIR" -type f -exec sed -ri ' \  
s!^(\s*CustomLog)\s+\S+!\1 /proc/self/fd/1!g; \  
s!^(\s*ErrorLog)\s+\S+!\1 /proc/self/fd/2!g; \  
' '{}' ';'  
RUN a2enmod rewrite  
  
# Add files.  
ADD redirector-start /redirector-start  
ADD apache2.conf /etc/apache2/apache2.conf  
ADD redirector.conf /etc/apache2/sites-enabled/000-default.conf  
  
# Define mountable directories.  
VOLUME ["/www-files", "/var/www/site", “/etc/apache2/sites-enabled”]  
  
EXPOSE 80  
CMD ["bash" , "/redirector-start"]  
  

