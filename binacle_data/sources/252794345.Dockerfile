FROM dasrick/fedora-php-base:5.6  
# THX to theLex aka Alexander Miehe <alexander.miehe@gmail.com>  
MAINTAINER Enrico Hoffmann <dasrick@gmail.com>  
  
WORKDIR /data  
  
RUN yum install -y php-mysqlnd php-gd php-soap && yum clean all  
  
ADD php.ini /etc/php.d/101-typo3.ini  
  
VOLUME /data  

