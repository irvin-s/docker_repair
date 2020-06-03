FROM centos:7  
MAINTAINER AttractGroup  
  
# Update the base system with latest patches  
RUN yum -y update && yum clean all  
RUN yum install -y epel-release  
  
#RUN yum install -y php55w php55w-opcache  
#RUN yum install -y php55w-cli php55w-common  
#RUN yum install -y php55w-fpm php55w-opcache  
# Install Main Programs  
RUN yum install -y \  
nginx \  
mysql \  
curl \  
nodejs \  
npm \  
git \  
supervisor  
  
# Install Cron  
RUN yum install -y cronie  
  
# Install required repos, update, and then install PHP-FPM  
RUN yum install -y \  
php-cli \  
php-fpm \  
php-common \  
php-mysql \  
php-gd \  
php-mcrypt \  
php-soap \  
php-curl \  
php-mbstring  
  
RUN rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm  
  
RUN yum -y install yum-plugin-replace  
RUN yum -y replace php-common --replace-with=php55w-common  
  
#Activate the new PHP version permanently  
#RUN source /opt/rh/php55/enable  
# Create session directory  
RUN mkdir -m 777 -p /var/lib/php/session  
  
# Set local IP  
RUN yum install -y iproute  
  
# Composer  
RUN curl -sS https://getcomposer.org/installer | php  
RUN mv composer.phar /usr/local/bin/composer  
  
# For mysql client  
ENV TERM dumb  
  
CMD ["/var/www/project/docker-main/start.sh"]

