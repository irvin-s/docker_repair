FROM debian:stretch

RUN apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y wget curl apt-transport-https ca-certificates unzip && \
	wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
	echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list && \
	apt-get update && apt-get install -y \
		curl \
		git \
		php7.3-cli \
		php7.3-mbstring \
		php7.3-intl \
		php7.3-json \
		php7.3-gd \
		php7.3-xml \
		php7.3-sqlite3 \
		php7.3-zip \
		php7.3-tokenizer && \
	curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
	cd /srv && \
	composer create-project nette/sandbox /srv && \
	apt-get remove -y curl wget git && \
	apt-get clean -y && apt-get autoclean -y && apt-get autoremove -y && \
	rm -rf /var/lib/apt/lists/* /var/lib/log/* /tmp/* /var/tmp/*

WORKDIR /srv

CMD php -S 0.0.0.0:80 -t /srv/www
