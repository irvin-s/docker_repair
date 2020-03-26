FROM php:7.2-fpm


# install the PHP extensions we need
RUN set -ex; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update && \
	apt-get install -y --no-install-recommends \
		libjpeg-dev \
		libpng-dev \
		libxml2-dev \
		gnupg \
		git-core \
		zip \
		unzip \
		mysql-client \
	    apt-transport-https \
	; \
	\
	docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
	docker-php-ext-install soap gd mysqli;


RUN apt remove cmdtest
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get update
RUN apt-get install nodejs yarn -yq

# Install XDebug
RUN pecl install xdebug-2.6.0 \
    && docker-php-ext-enable xdebug

# Install PHPCS
WORKDIR /tmp

RUN curl -OL https://squizlabs.github.io/PHP_CodeSniffer/phpcs.phar && \
    cp /tmp/phpcs.phar /usr/local/bin/phpcs && \
    chmod +x /usr/local/bin/phpcs

# Install Composer
WORKDIR /tmp

RUN curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
&& curl -o /tmp/composer-setup.sig https://composer.github.io/installer.sig \
# Make sure we're installing what we think we're installing!
&& php -r "if (hash('SHA384', file_get_contents('/tmp/composer-setup.php')) !== trim(file_get_contents('/tmp/composer-setup.sig'))) { unlink('/tmp/composer-setup.php'); echo 'Invalid installer' . PHP_EOL; exit(1); }" \
&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
&& rm -f /tmp/composer-setup.*

# Install WPCLI
WORKDIR /tmp
RUN curl -OL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN cp /tmp/wp-cli.phar /usr/local/bin/wp
RUN chmod +x /usr/local/bin/wp && \
echo 'wp() {' >> ~/.bashrc && \
echo '/usr/local/bin/wp "$@" --allow-root' >> ~/.bashrc && \
echo '}' >> ~/.bashrc

WORKDIR /var/www/html
VOLUME /var/www/html
