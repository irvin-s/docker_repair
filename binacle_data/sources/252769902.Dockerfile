FROM debian:jessie  
MAINTAINER Arris Ray <arris.ray@gmail.com>  
ENV DEBIAN_FRONTEND noninteractive  
  
# Install packages  
RUN apt-get update \  
&& apt-get update \  
&& apt-get clean \  
&& apt-get -yq install \  
supervisor \  
apache2 \  
vim \  
&& rm -rf /var/lib/apt/lists/*  
  
# Configure Apache vhost  
RUN rm -rf /var/www/*  
RUN rm -rf /etc/apache2/sites-enabled/*  
ADD vhost.conf /etc/apache2/sites-enabled/000-default.conf  
  
# Configure Apache mod(s)  
RUN a2enmod rewrite  
  
# Setup shared volume(s)  
ADD . /var/www/html  
RUN usermod -u 1000 www-data  
RUN usermod -G staff www-data  
  
# Setup Vim  
ADD .vimrc /root/.vimrc  
  
# Startup script(s)  
ADD start.sh /opt/start.sh  
ADD start_apache2.sh /opt/start_apache2.sh  
RUN chmod 0755 /opt/*.sh  
ADD supervisord_apache2.conf /etc/supervisor/conf.d/supervisord_apache2.conf  
CMD ["/opt/start.sh"]  
  

