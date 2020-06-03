FROM dasrick/fedora-php-typo3:5.6  
# THX to theLex aka Alexander Miehe <alexander.miehe@gmail.com>  
MAINTAINER Enrico Hoffmann <dasrick@gmail.com>  
  
RUN yum install -y php-pecl-xdebug && yum -y clean all  
  
ADD xdebug.ini /etc/php.d/100-xdebug.ini  
ADD xdebug /usr/bin/xdebug  
  
RUN chmod +x /usr/bin/xdebug  
  
EXPOSE 9000

