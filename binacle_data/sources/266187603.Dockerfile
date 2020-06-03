FROM alpine:edge
MAINTAINER Paul Smith <pa.ulsmith.net>

# Add repos
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Add basics first
RUN apk update && apk upgrade && apk add \
	bash apache2 php5-apache2 curl ca-certificates openssl git php5 php5-phar php5-json php5-iconv php5-openssl tzdata openntpd vim nano

# Setup apache and php
RUN apk add \
	php5-ftp \
	php5-mcrypt \
	php5-soap \
	php5-gmp \
	php5-pdo_odbc \
	php5-dom \
	php5-pdo \
	php5-zip \
	php5-mysqli \
	php5-sqlite3 \
	php5-pdo_pgsql \
	php5-bcmath \
	php5-gd \
	php5-odbc \
	php5-pdo_mysql \
	php5-pdo_sqlite \
	php5-gettext \
	php5-xmlrpc \
	php5-bz2 \
	php5-pdo_dblib \
	php5-curl \
	php5-ctype \
	sqlite \
	rsync pwgen netcat-openbsd\
	&& cp /usr/bin/php5 /usr/bin/php \
    && rm -f /var/cache/apk/*

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# enabling SSH
RUN apk --update add --no-cache openssh \
  && sed -i s/#PermitRootLogin.*/PermitRootLogin\ yes/ /etc/ssh/sshd_config \
  && echo "root:THISISNOTFORLOGIN102i3709123" | chpasswd \
  && rm -rf /var/cache/apk/*
RUN sed -ie 's/#Port 22/Port 22/g' /etc/ssh/sshd_config
RUN sed -ri 's/#HostKey \/etc\/ssh\/ssh_host_key/HostKey \/etc\/ssh\/ssh_host_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_dsa_key/HostKey \/etc\/ssh\/ssh_host_dsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ecdsa_key/HostKey \/etc\/ssh\/ssh_host_ecdsa_key/g' /etc/ssh/sshd_config
RUN sed -ir 's/#HostKey \/etc\/ssh\/ssh_host_ed25519_key/HostKey \/etc\/ssh\/ssh_host_ed25519_key/g' /etc/ssh/sshd_config
RUN printf "\\nClientAliveInterval 15\\nClientAliveCountMax 8" >> /etc/ssh/sshd_config
RUN /usr/bin/ssh-keygen -A
RUN ssh-keygen -t rsa -b 4096 -f /etc/ssh/ssh_host_key

# Add apache to run and configure
RUN mkdir /run/apache2 \
    && sed -i "s/#LoadModule\ rewrite_module/LoadModule\ rewrite_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ session_module/LoadModule\ session_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ session_cookie_module/LoadModule\ session_cookie_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ session_crypto_module/LoadModule\ session_crypto_module/" /etc/apache2/httpd.conf \
    && sed -i "s/#LoadModule\ deflate_module/LoadModule\ deflate_module/" /etc/apache2/httpd.conf \
    && sed -i "s#^DocumentRoot \".*#DocumentRoot \"/var/www/html\"#g" /etc/apache2/httpd.conf \
    && sed -i "s#/var/www/localhost/htdocs#/var/www/html#" /etc/apache2/httpd.conf \
    && printf "\n<Directory \"/var/www/html\">\n\tAllowOverride All\n</Directory>\n" >> /etc/apache2/httpd.conf

# add flag
ARG username
ENV username=${username}

# create user
RUN adduser -D -u 1000 $username

# create webroot directory
RUN mkdir -p /var/www/html

# add challs
ADD challs /var/www/html

# remove README.md
RUN rm -f /var/www/html/README.md

# change ownership and mode
RUN chown -R root:$username /var/www/html/* && chmod -R 775 /var/www/html/* && mkdir bootstrap
RUN chown -R apache:apache /var/www/html/sqlite
RUN chown -R apache:apache /var/www/html/assets
RUN chown -R apache:apache /var/www/html/runtime

# composer install
WORKDIR /var/www/html
RUN composer install --no-dev

# store
ARG flag
ARG flag_name
ARG password
ENV flag=${flag}
ENV flag_name=${flag_name}
ENV password=${password}
RUN echo "$username:$password" | chpasswd

# store and securing flag
RUN echo $flag > /var/www/html/flag/$flag_name
RUN sed -i "s/flag.txt/$flag_name/g" /var/www/html/views/site/index.php
RUN chown -R root:root /var/www/html/flag && chmod -R 755 /var/www/html/flag

#bootstrap
ADD start.sh /bootstrap/
RUN chmod +x /bootstrap/start.sh

EXPOSE 80 22
ENTRYPOINT ["/bootstrap/start.sh"]
