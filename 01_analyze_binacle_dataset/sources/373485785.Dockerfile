FROM ubuntu:14.04
MAINTAINER Alexey Masolov <alexey.masolov@gmail.com>

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Preparation for sshd
RUN mkdir /var/run/sshd

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN ln -sf /proc/mounts /etc/mtab
RUN apt-get -y upgrade

# Basic Requirements
RUN apt-get -y install mysql-server mysql-client nginx php5-fpm php5-mysql php-apc pwgen python-setuptools curl git unzip openssh-server openssl

# OctoberCMS Requirements
RUN apt-get -y install php5-curl php5-gd php5-mcrypt php5-memcache php5-memcached php5-sqlite php5-json libphp-pclzip

# Add october user for ssh access
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/#PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config
RUN useradd -m -d /home/october -p $(openssl passwd -1 'temp') -G sudo -s /bin/bash october 
RUN echo "october ALL=(ALL:ALL) ALL" >> /etc/sudoers

# mysql config
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# nginx config
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# php-fpm config
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php5/fpm/pool.d/www.conf
RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;
RUN php5enmod mcrypt

# nginx site conf
ADD ./nginx-site.conf /etc/nginx/sites-available/default

# Supervisor Config
RUN /usr/bin/easy_install supervisor
RUN /usr/bin/easy_install supervisor-stdout
ADD ./supervisord.conf /etc/supervisord.conf

# Install composer
RUN cd /usr/local/sbin/ && curl -sS https://getcomposer.org/installer | php && mv composer.phar composer

# Install OctoberCMS
RUN cd /usr/share/nginx/ && composer -n create-project october/october october dev-master
RUN mv /usr/share/nginx/html/5* /usr/share/nginx/october
RUN rm -rf /usr/share/nginx/html/
RUN mv /usr/share/nginx/october /usr/share/nginx/html
RUN chown -R www-data:www-data /usr/share/nginx/html

# Wordpress Initialization and Startup Script
ADD ./start.sh /start.sh
RUN chmod 755 /start.sh

# private expose
EXPOSE 3306
EXPOSE 80
EXPOSE 22

CMD ["/bin/bash", "/start.sh"]
