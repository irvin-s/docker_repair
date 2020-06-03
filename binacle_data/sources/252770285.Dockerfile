# Dockerfile for Crits  
FROM httpd:latest  
MAINTAINER Adam Sealey <asealey@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV LC_ALL C  
  
# Install Updates  
RUN apt-get update && apt-get install -y \  
git \  
python  
  
########## Setup Apache ###########  
########## Setup Akamai Listener ###########  
# Copy up the resources  
ENV HTTPD_HTDOCS $HTTPD_PREFIX/htdocs  
ENV HTTPD_CONF_DIR /usr/local/apache2/conf  
  
ADD resources/index.cgi $HTTPD_HTDOCS/  
RUN rm -f $HTTPD_HTDOCS/index.html && \  
chgrp -R www-data $HTTPD_HTDOCS && \  
chmod +x $HTTPD_HTDOCS/index.cgi  
  
ADD resources/httpd.conf $HTTPD_CONF_DIR/  
ADD resources/httpd-ssl.conf $HTTPD_CONF_DIR/extra/  
RUN mkdir $HTTPD_CONF_DIR/ssl && \  
chgrp -R www-data $HTTPD_CONF_DIR/  
  
# Setup the logging path  
ENV AKAMAI_LOG_PATH /syslog/remote/net/akamai/cis-akamai/  
RUN mkdir -p $AKAMAI_LOG_PATH && \  
chgrp -R daemon $AKAMAI_LOG_PATH && \  
chmod -R g+w $AKAMAI_LOG_PATH  
  
EXPOSE 80  
EXPOSE 443  
VOLUME "/usr/local/apache2/conf/ssl"  
VOLUME "/syslog/remote/net/akamai/cis-akamai"  
  
# Start up apache  
#ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  

