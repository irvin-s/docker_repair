# ===============================================================================
# Dockerfile
#   "Wordpress + Nginx + Cached + NoDB" docker image - production ready
#
# What's it included:
#
# - php-fpm
# - Wordpress - build with the **latest** version
# - Nginx - as reverse proxy, HTTP / HTTPS enabled.
# - Cache - fastcgi-cache, fastcgi_cache_purge, Opcache
# - No DB included.
#
# Optional
#
# - Deploy `letsencrypt` SSL.
# - Deploy normal SSL.
#
# @link https://letsencrypt.org/ | letsencrypt
#
# It is based on Ubuntu 14.04 LTS
# ===============================================================================

# Set the base image to Ubuntu
FROM ubuntu:14.04

# File Author / Maintainer
MAINTAINER Lei SHI <foxshee@gmail.com>

# Default HTTP and HTTPS ports
EXPOSE 80 443


# ===============================================================================
# Env. Setup
#

# Keep upstart from complaining
RUN dpkg-divert --local --rename --add /sbin/initctl && \
	ln -sf /bin/true /sbin/initctl

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive

# Update the repository sources list and finish upgrade
RUN apt-get update && apt-get -y upgrade

# ----------------------------------------------------------
# Dependencies
# ----------------------------------------------------------

# Basic Dependencies
#
# The basic dependecies includes:
#
# - PHP & fpm
# - MySQL client
# - curl
# - Git
# - pwgen - Open-Source Password Generator
# - python-setuptools - for `easy_install`
#
RUN apt-get install -y mysql-client \
						php5-fpm \
						php5-mysql \
						pwgen \
						python-setuptools \
						curl \
						git \
						unzip


# **Wordpress** Dependencies
RUN apt-get install -y php5-curl \
						php5-gd \
						php5-intl \
						php-pear \
						php5-imagick \
						php5-imap \
						php5-mcrypt \
						php5-memcache \
						php5-ming \
						php5-ps \
						php5-pspell \
						php5-recode \
						php5-sqlite \
						php5-tidy \
						php5-xmlrpc \
						php5-xsl

### ---- FIX -----
# Fix 'add-apt-repository: not found' in Ubuntu 14.04 LTS
RUN apt-get -y install software-properties-common \
						python-software-properties


# ----------------------------------------------------------
# Nginx
#
#   Nginx compiled with `fastcgi_cache` and `fastcgi_cache_purge`
#
# @link https://easyengine.io/wordpress-nginx/tutorials/single-site/fastcgi-cache-with-purging/
# ----------------------------------------------------------

RUN add-apt-repository ppa:rtcamp/nginx && \
	apt-get update && \
	apt-get remove nginx* && \
	apt-get install -y nginx-custom


############################################################
# Configurations
#

# ----------------------------------------------------------
# Nginx Config
# ----------------------------------------------------------

# Create uer for Nginx running
RUN adduser --system --no-create-home --shell /bin/false --group --disabled-login www-front

# Copy config files to `/etc/nginx/` folder
COPY  config/nginx.conf /etc/nginx/nginx.conf

COPY  config/nginx-site-http.conf /etc/nginx/nginx-site-http.conf
COPY  config/nginx-site-https.conf /etc/nginx/nginx-site-https.conf
# Default **site** config - HTTP
# Later if need to enforce SSL, use `nginx-site-http.conf` instead.
COPY  config/nginx-site-http.conf /etc/nginx/sites-available/default

COPY  config/nginx-ssl.conf /etc/nginx/ssl-template.conf
COPY  config/nginx-restrictions.conf /etc/nginx/restrictions.conf


# ----------------------------------------------------------
# PHP-fpm Config
# ----------------------------------------------------------

RUN sed -i -e "s/;cgi.fix_pathinfo\s*=\s*1/cgi.fix_pathinfo = 0/g; s/expose_php\s*=\s*On/expose_php = Off/g" \
/etc/php5/fpm/php.ini
RUN sed -i -e "s/expose_php\s*=\s*On/expose_php = Off/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g; s/post_max_size\s*=\s*8M/post_max_size = 100M/g" \
/etc/php5/fpm/php.ini
#RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php5/fpm/php.ini

RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf

RUN sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g; s/listen\s*=\s*\/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g; s/;listen.allowed_clients\s*=\s*127.0.0.1/listen.allowed_clients = 127.0.0.1/g" \
/etc/php5/fpm/pool.d/www.conf
#RUN sed -i -e "s/listen\s*=\s*\/var\/run\/php5-fpm.sock/listen = 127.0.0.1:9000/g" /etc/php5/fpm/pool.d/www.conf
#RUN sed -i -e "s/;listen.allowed_clients\s*=\s*127.0.0.1/listen.allowed_clients = 127.0.0.1/g" /etc/php5/fpm/pool.d/www.conf


# ----------------------------------------------------------
# Opcode Config
# ----------------------------------------------------------

RUN sed -i -e"s/^;opcache.enable\s*=\s*0/opcache.enable = 1/; s/^;opcache.max_accelerated_files\s*=\s*2000/opcache.max_accelerated_files = 4000/" /etc/php5/fpm/php.ini
#RUN sed -i -e"s/^;opcache.max_accelerated_files\s*=\s*2000/opcache.max_accelerated_files = 4000/" /etc/php5/fpm/php.ini


# ===============================================================================
# Install & Config Supervisor
#
# Supervisor is a process manager which makes managing a number of long-running programs a trivial task
#   by providing a consistent interface through which they can be monitored and controlled.
#
# it uses `easy_install` (from `python-setuptools`) to install **supervisor**.
#
# @link http://supervisord.org/#
#

RUN /usr/bin/easy_install supervisor && \
	/usr/bin/easy_install supervisor-stdout
COPY  config/supervisord.conf /etc/supervisord.conf



# ===============================================================================
# Install Wordpress
#

# Get the code of  **latest** version.
RUN cd /usr/share/nginx/ && \
    curl -o wp-latest.tar.gz https://wordpress.org/latest.tar.gz && \
    tar -xvf wp-latest.tar.gz && \
    rm wp-latest.tar.gz

# Target **webroot** - `/usr/share/nginx/www`
RUN rm -rf /usr/share/nginx/www && \
	mv /usr/share/nginx/wordpress /usr/share/nginx/www && \
	chown -R www-data:www-data /usr/share/nginx/www



# ===============================================================================
# System Initialization
#

## Copy the **pre-defined** bash script
COPY bash/init.sh /init.sh
## Modify the permisison - make sure they are excuatable
RUN chmod 755 /init.sh

# Set up default CMD
CMD ["/bin/bash", "/init.sh"]

# ===============================================================================
# Copy "optional" scripts
#
# Under `/addon` folder.
#

# `letsencrypt` SSL related
# @link https://letsencrypt.org/ | letsencrypt
COPY bash/ssl-letsencrypt.sh /addon/letsencrypt/ssl-letsencrypt.sh

# Normal SSL related
COPY bash/ssl.sh /addon/ssl.sh

# Install WP plugins
COPY bash/wp-install-plugins.sh /addon/wp-install-plugins.sh


# ===============================================================================
# Volume Mounting
#
# - Wprdpress webroot
# - Log
#

# Mount the volumns
VOLUME ["/usr/share/nginx/www", "/var/log"]

