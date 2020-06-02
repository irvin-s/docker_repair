FROM alpine:edge
MAINTAINER Paul Smith <pa.ulsmith.net>

# Add repos
RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# Add basics first
RUN apk update && apk upgrade && apk add \
  bash apache2 php7-apache2 curl ca-certificates openssl git php7 php7-phar php7-json php7-iconv php7-openssl tzdata openntpd vim nano

# Add Composer
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer

# Setup apache and php
RUN apk add \
  php7-ftp \
  php7-xdebug \
  php7-mcrypt \
  php7-mbstring \
  php7-soap \
  php7-gmp \
  php7-pdo_odbc \
  php7-dom \
  php7-pdo \
  php7-zip \
  php7-mysqli \
  php7-sqlite3 \
  php7-pdo_pgsql \
  php7-bcmath \
  php7-gd \
  php7-odbc \
  php7-pdo_mysql \
  php7-pdo_sqlite \
  php7-gettext \
  php7-xmlreader \
  php7-xmlwriter \
  php7-simplexml \
  php7-tokenizer \
  php7-xmlrpc \
  php7-bz2 \
  php7-pdo_dblib \
  php7-curl \
  php7-ctype \
  php7-session \
  php7-redis \
  sqlite \
  rsync pwgen netcat-openbsd\
  && cp /usr/bin/php7 /usr/bin/php \
    && rm -f /var/cache/apk/*

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
ARG flag
ARG flag_name
ARG username
ARG password
ENV flag=${flag}
ENV flag_name=${flag_name}
ENV username=${username}
ENV password=${password}

# create user
RUN adduser -D -u 1000 $username
RUN echo "$username:$password" | chpasswd

# create webroot directory
RUN mkdir -p /var/www/html

# add challs
ADD challs /var/www/html

# remove README.md
RUN rm -f /var/www/html/README.md

# change ownership and mode
RUN chown -R root:$username /var/www/html/* && chmod -R 775 /var/www/html/* && mkdir bootstrap
RUN chown -R apache:apache /var/www/html/sqlite
RUN chown -R apache:apache /var/www/html/static

# store and securing flag
RUN adduser -D -g "$flag" -u 1337 flag
RUN echo "flag:thisisonlyforsecuritypurpose" | chpasswd

#bootstrap
ADD start.sh /bootstrap/
RUN chmod +x /bootstrap/start.sh
#CMD ["/usr/sbin/sshd", "-D"]

EXPOSE 80 22
ENTRYPOINT ["/bootstrap/start.sh"]
