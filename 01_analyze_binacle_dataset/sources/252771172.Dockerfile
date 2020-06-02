FROM centos:latest  
MAINTAINER Aiden Lee <aiden.lee.developer@gmail.com>  
  
RUN yum update -y && \  
yum install -y epel-release && \  
yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm && \  
yum install -y --enablerepo=epel nginx && \  
yum install -y --enablerepo=remi-php56 \  
php \  
php-fpm \  
php-gd \  
php-mbstring \  
php-mcrypt \  
php-xml \  
php-json \  
php-pdo \  
php-mysqlnd \  
php-pgsql && \  
yum install -y gettext && \  
yum clean all && \  
rm -rf /etc/nginx/* && rm -rf /var/www/*  
  
VOLUME ["/var/www", "/var/lib/nginx", "/var/lib/php"]  
  
EXPOSE 80  
COPY ["etc/nginx/", "/etc/nginx/"]  
COPY ["usr/sbin/startup.sh", "/usr/sbin/"]  
  
RUN chmod +x /usr/sbin/startup.sh  
  
CMD ["/usr/sbin/startup.sh"]

