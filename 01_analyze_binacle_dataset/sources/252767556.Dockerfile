FROM abwebfreelance/base:latest  
MAINTAINER "AB Web Freelance (Auriams Berskys)" <a.berskys@gmail.com>  
  
ENV REPO http://rpms.famillecollet.com/enterprise/remi-release-7.rpm  
ENV GITHUB_TOKEN 40824bd577a40950326cc6f511f0bab2f59a6d7b  
ENV WWW_DIR /var/www  
  
COPY entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
  
COPY init.sh /init.sh  
RUN chmod +x /init.sh  
  
CMD ["fpm"]  
ENTRYPOINT ["/entrypoint.sh"]  
  
WORKDIR $WWW_DIR  
  
EXPOSE 9000  
# Install repo  
RUN yum install -y $REPO && yum clean all  
  
# install php with packages  
RUN yum install --enablerepo=remi,remi-php71 -y \  
git \  
php-bcmath \  
php-cli \  
php-mcrypt \  
php-memcached \  
php-curl \  
php-fpm \  
php-gd \  
php-iconv \  
php-intl \  
php-mysql \  
php-mbstring \  
php-pdo \  
php-pdo_mysql \  
php-process \  
php-soap \  
php-pecl-zip \  
php-xml \  
php-pecl-xdebug && \  
yum clean all  
  
# change permissions for default php session and wsdl cache directories  
RUN chown www:www -R /var/lib/php  
  
# set custom configuration  
RUN echo "date.timezone=Europe/Vilnius" > /etc/php.d/30-timezone.ini && \  
echo "cgi.fix_pathinfo=0" > /etc/php.d/30-cgi.ini && \  
echo "display_errors=stderr" > /etc/php.d/30-errors.ini  
  
# copy default configuration of fpm  
COPY www.conf /etc/php-fpm.d/www.conf  
  
# install composer  
RUN curl -sS https://getcomposer.org/installer | php -- \  
\--install-dir=/usr/bin \  
\--filename=composer && \  
composer config -g github-oauth.github.com $GITHUB_TOKEN  
  
COPY debug.sh /usr/local/bin/php-debug  

