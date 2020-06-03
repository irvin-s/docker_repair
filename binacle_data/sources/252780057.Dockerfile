FROM centos:centos7  
MAINTAINER John Cedrick Manacsa, jcmanacsa@ayannah.com  
  
COPY etc/yum.repos.d/remi.repo /etc/yum.repos.d/remi.repo  
  
RUN yum install -y epel-release && \  
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm && \  
yum upgrade -y && \  
yum install -y \  
supervisor \  
php \  
php-cli \  
php-common \  
php-fpm \  
php-gd \  
php-mbstring \  
php-mcrypt \  
php-mysqlnd \  
php-pdo \  
php-pear \  
php-pecl-jsonc \  
php-pecl-zip \  
php-pecl-uuid \  
php-process \  
php-xml \  
git \  
php-soap \  
ssmtp && \  
yum clean all -y && \  
rm -rf /var/cache/yum/* /tmp/*  
  
  
COPY etc /etc/  
  
EXPOSE 9000  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["sendah"]  

