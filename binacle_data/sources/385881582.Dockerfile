from ubuntu:12.04

MAINTAINER Thatcher Peskens <thatcher@koffiedik.net>

RUN apt-get update

# install and configure nginx
RUN apt-get install -y nginx
RUN mkdir /var/www

# install some convenience tools
RUN apt-get install -y vim curl rsync mysql-client

# ADD nginx/nginx.conf /etc/nginx/
# ADD nginx/sites-available/magento /etc/nginx/sites-available/default

# install and configure php-fpm
RUN apt-get install -y php5-fpm php5-mysql php5-curl php5-mcrypt php5-gd 

# ADD php5/php.ini /etc/php5/fpm/php.ini
# ADD php5/php-fpm.conf /etc/php5/fpm/php-fpm.conf
# ADD php5/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf

# install sshd
RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd 
# to get access mount with -v authorized_keys from the host system

# install supervisord
RUN apt-get install -y supervisor
## ADD supervisor/conf.d/ /etc/supervisor/conf.d/
## ADD supervisor/supervisord.conf /etc/supervisor/

# install some convenience tools
RUN apt-get install -y vim curl rsync mysql-client

ADD . /configs

RUN ln -sf /configs/nginx/nginx.conf /etc/nginx/nginx.conf
RUN ln -sf /configs/nginx/sites-available/magento /etc/nginx/sites-enabled/default

RUN ln -sf /configs/supervisor/supervisord.conf /etc/supervisor/
RUN ln -sf /configs/supervisor/conf.d/apps.conf /etc/supervisor/conf.d/apps.conf
RUN ln -sf /configs/php5/php.ini /etc/php5/fpm/php.ini
RUN ln -sf /configs/php5/php-fpm.conf /etc/php5/fpm/php-fpm.conf
RUN ln -sf /configs/php5/pool.d/www.conf /etc/php5/fpm/pool.d/www.conf


# install a site
ADD www /var/www

EXPOSE 22 80 443
CMD bash
