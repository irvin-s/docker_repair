FROM debian:stable  
MAINTAINER boogy <theboogymaster@gmail.com>  
## Inspired by eboraas/apache  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update \  
&& apt-get upgrade \  
&& apt-get -y install apache2 php5 php5-mysql libapache2-mpm-itk \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
ENV APACHE_RUN_USER www-data  
ENV APACHE_RUN_GROUP www-data  
ENV APACHE_LOG_DIR /var/log/apache2  
  
RUN /usr/sbin/a2ensite default-ssl \  
&& /usr/sbin/a2enmod ssl \  
&& /usr/sbin/a2dismod 'mpm_*' \  
&& /usr/sbin/a2enmod mpm_prefork  
  
EXPOSE 80 443  
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]  

