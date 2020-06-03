FROM ubuntu:14.04
MAINTAINER Andy Jenkins <andy@gear11.com>, with thanks to github.com/eugeneware

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

# Let the conatiner know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get -y upgrade

RUN echo Installing dependencies via Yum
# Basic Requirements
RUN apt-get -y install mysql-server mysql-client nginx php5-fpm php5-mysql php-apc pwgen python-setuptools curl git unzip

# Wordpress Requirements
RUN apt-get -y install php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl

RUN echo Installing supervisor
RUN /usr/bin/easy_install supervisor
RUN /usr/bin/easy_install supervisor-stdout

RUN echo Installing the WordPress CLI
RUN curl -L "https://raw.github.com/wp-cli/builds/gh-pages/phar/wp-cli.phar" > /usr/bin/wp
RUN chmod +x /usr/bin/wp

RUN echo Configuring MySQL
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

RUN echo Configuring Nginx
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN echo Configuring PHP-FPM
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf
RUN sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php5/fpm/pool.d/www.conf
RUN find /etc/php5/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

RUN echo Deploying project assets
ADD . /G11DockerWP

RUN echo Deploying Nginx and supervisord conf files
RUN cp /G11DockerWP/docker-wordpress-nginx/nginx-site.conf /etc/nginx/sites-available/default
RUN cp /G11DockerWP/docker-wordpress-nginx/supervisord.conf /etc/supervisord.conf

RUN echo Starting services
# We use ENTRYPOINT rather than CMD so that args after the image name go to us.
# The first time you run this, pass in the new WordPress base URL as an argument,
# in order to fix up links in the database
ENTRYPOINT ["/bin/bash", "/G11DockerWP/start.sh" ]

# private expose
EXPOSE 80
