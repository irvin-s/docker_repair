FROM alpine:edge

RUN echo 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories

RUN apk update && \
	apk add nginx curl supervisor \
	php7 \
	php7-fpm \
	php7-zip \
	php7-mbstring \
	php7-xml \
	php7-mysqli \
	php7-json \
	php7-phar \
	php7-dom \
	php7-xmlwriter \
	php7-tokenizer \
	php7-session \
	php7-mongodb \
	php7-pdo

COPY nginx.conf /etc/nginx/nginx.conf

COPY supervisord.conf /etc/supervisor/supervisord.conf
#http://supervisord.org/configuration.html default route start supervisord.conf

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
	php composer-setup.php && \
	php -r "unlink('composer-setup.php');" && \
	mv composer.phar /usr/local/bin/composer

WORKDIR /var/www/html

ENTRYPOINT ["supervisord"]