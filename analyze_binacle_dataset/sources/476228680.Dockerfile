FROM httpd-php

MAINTAINER fatherlinux <scott.mccarty@gmail.com>

USER 1001

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /etc/opt/rh/rh-php72/opcache-recommended.ini

VOLUME /var/www/html

ENV WORDPRESS_VERSION 4.4.2
ENV WORDPRESS_SHA1 7444099fec298b599eb026e83227462bcdf312a6

# upstream tarballs include ./wordpress/ so this gives us /usr/src/wordpress
RUN curl -o /usr/src/wordpress.tar.gz -SL https://wordpress.org/wordpress-${WORDPRESS_VERSION}.tar.gz \
	&& echo "$WORDPRESS_SHA1 /usr/src/wordpress.tar.gz" | sha1sum -c - \
	&& tar -xzf /usr/src/wordpress.tar.gz -C /usr/src/ \
	&& rm /usr/src/wordpress.tar.gz

COPY ./docker-entrypoint.sh /entrypoint.sh

# grr, ENTRYPOINT resets CMD now
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/cmd.sh"]
