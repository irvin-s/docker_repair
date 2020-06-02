FROM php:7.1-apache

# System dependencies
RUN set -ex; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		git \
		imagemagick \
		# Required for SyntaxHighlighting
		python \
	; \
	rm -rf /var/lib/apt/lists/*

# Install the PHP extensions we need
RUN set -ex; \
	\
	savedAptMark="$(apt-mark showmanual)"; \
	\
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libicu-dev \
	; \
	\
	docker-php-ext-install \
		intl \
		mbstring \
		mysqli \
		opcache \
	; \
	\
	pecl install apcu-5.1.16; \
	docker-php-ext-enable \
		apcu \
	; \
	\
	# reset apt-mark's "manual" list so that "purge --auto-remove" will remove all build dependencies
	apt-mark auto '.*' > /dev/null; \
	apt-mark manual $savedAptMark; \
	ldd "$(php -r 'echo ini_get("extension_dir");')"/*.so \
		| awk '/=>/ { print $3 }' \
		| sort -u \
		| xargs -r dpkg-query -S \
		| cut -d: -f1 \
		| sort -u \
		| xargs -rt apt-mark manual; \
	\
	apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
		echo 'opcache.memory_consumption=128'; \
		echo 'opcache.interned_strings_buffer=8'; \
		echo 'opcache.max_accelerated_files=4000'; \
		echo 'opcache.revalidate_freq=60'; \
		echo 'opcache.fast_shutdown=1'; \
		echo 'opcache.enable_cli=1'; \
	} > /usr/local/etc/php/conf.d/opcache-recommended.ini

# SQLite Directory Setup
RUN mkdir -p /var/www/data \
	&& chown -R www-data:www-data /var/www/data

# Version
ENV MEDIAWIKI_MAJOR_VERSION 1.27
ENV MEDIAWIKI_BRANCH REL1_27
ENV MEDIAWIKI_VERSION 1.27.6
ENV MEDIAWIKI_SHA512 e6b43fe2e90a63d89673bdb6e201fffcec407a388f07c169f84df753c1c50596d54ba1b687157a1ac4b8d8bdaf4a5eadf74dc045a4b955fca4f00c66b6544b33

# MediaWiki setup
RUN curl -fSL "https://releases.wikimedia.org/mediawiki/${MEDIAWIKI_MAJOR_VERSION}/mediawiki-${MEDIAWIKI_VERSION}.tar.gz" -o mediawiki.tar.gz \
	&& echo "${MEDIAWIKI_SHA512} *mediawiki.tar.gz" | sha512sum -c - \
	&& tar -xz --strip-components=1 -f mediawiki.tar.gz \
	&& rm mediawiki.tar.gz \
	&& chown -R www-data:www-data extensions skins cache images
