FROM nginx
MAINTAINER Azure App Service Container Images <appsvc-images@microsoft.com>

# ========
# ENV vars
# ========

# ssh
ENV SSH_PASSWD "root:Docker!"

# Composer
# Updation: https://getcomposer.org/download/
ENV COMPOSER_DOWNLOAD_URL "https://getcomposer.org/installer"
ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /home/.composer
ENV COMPOSER_VERSION "1.6.1"
# SHA384SUM https://composer.github.io/installer.sha384sum
ENV COMPOSER_SETUP_SHA 544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061

#Web Site Home
ENV HOME_SITE "/home/site/wwwroot"

#
ENV DOCKER_BUILD_HOME "/dockerbuild"

# ====================
# Download and Install
# ~. essentials
# 1. php7.0-common/php7.0-fpm/php-pear/php7.0-apcu
# 2. ssh
# 3. drush
# 4. composer
# ====================
COPY * /tmp/

        # -------------
	# ~. essentials
	# -------------
WORKDIR $DOCKER_BUILD_HOME
RUN set -ex \
	&& essentials=" \
		ca-certificates \
	" \
	&& apt-get update \
	&& apt-get install -y -V --no-install-recommends $essentials \
	&& rm -r /var/lib/apt/lists/*

	# ------------------
        # 1. php7.0-common/php7.0-fpm/php-pear/php7.0-apcu
	# ------------------
RUN set -ex \
        && phps=" \
		php7.0-common \
                php7.0-fpm \
                php-pear \
                php7.0-apcu \
                php7.0-gd \
                php7.0-dba \
                php7.0-mysql \
	" \
        && apt-get update \
	&& apt-get install -y -V --no-install-recommends $phps \
	&& rm -r /var/lib/apt/lists/* 

        # ------
	# 2. ssh
	# ------
RUN set -ex \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends openssh-server \
	&& echo "$SSH_PASSWD" | chpasswd 
   
	# ------
	# 3. drush
	# ------
RUN set -ex \
       && php -r "readfile('http://files.drush.org/drush.phar');" > /usr/local/bin/drush \
       && chmod +x /usr/local/bin/drush 
	
	# ------
	# 4. composer
	# ------
RUN set -ex \
	&& php -r "readfile('https://getcomposer.org/installer');" > /tmp/composer-setup.php \
       && php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) === getenv('COMPOSER_SETUP_SHA')) { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('/tmp/composer-setup.php'); echo PHP_EOL; exit(1); } echo PHP_EOL;" \
   	&& mkdir -p /composer/bin \
       && php /tmp/composer-setup.php --install-dir=/usr/local/bin/ --filename=composer --version=${COMPOSER_VERSION} \
       && rm /tmp/composer-setup.php  

	# ----------
	# ~. clean up
	# ----------
RUN set -ex \
	&& apt-get autoremove -y

# =========
# Configure
# =========

RUN \
   test -d /home/LogFiles/ || mkdir -p /home/LogFiles \
   && test -d /home/site/wwwroot/ || mkdir -p /home/site/wwwroot \
   && rm -rf /var/www/html 

WORKDIR /home/site/wwwroot

# ssh
COPY sshd_config /etc/ssh/
 
# php
COPY php.ini /etc/php/7.0/cli/php.ini
COPY www.conf /etc/php/7.0/fpm/pool.d/www.conf

# nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY hostingstart.html /home/site/wwwroot/index.html

RUN \
   echo "<?php" >> index.php && echo "phpinfo();" >> index.php 

# =====
# final
# =====
COPY init_container.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init_container.sh

EXPOSE 2222 80
ENTRYPOINT ["init_container.sh"]
