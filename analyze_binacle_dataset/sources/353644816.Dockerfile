# Dockerfile for PHP Web Article Extractor 
# https://github.com/zackslash/PHP-Web-Article-Extractor

FROM ubuntu:14.04

MAINTAINER Luke Hines <lukehines1+opensource@gmail.com>

# Install base packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        curl \
        apache2 \
        libapache2-mod-php5 \
        php5-curl \
        php-pear \
        php-apc && \
    rm -rf /var/lib/apt/lists/* && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini

# Generate base composer project
RUN mkdir -p /proj && rm -fr /var/www/html && ln -s /proj /var/www/html && \
	touch /proj/composer.json && \
	echo "{ \"require\": { \"zackslash/php-web-article-extractor\": \"*\" } }" >> /proj/composer.json

# Install any project dependencies through composer
WORKDIR /proj
RUN composer install && \
	rm -r /proj/vendor/zackslash/php-web-article-extractor/res && \
	rm -r /proj/vendor/zackslash/php-web-article-extractor/src

# Use local project source and resources to build this image
ADD res /proj/vendor/zackslash/php-web-article-extractor/res
ADD src /proj/vendor/zackslash/php-web-article-extractor/src
ADD cmd /proj/vendor/zackslash/php-web-article-extractor/cmd

RUN chmod +x /proj/vendor/zackslash/php-web-article-extractor/cmd/run.sh

ENV ALLOW_OVERRIDE **False**
WORKDIR /proj/vendor/zackslash/php-web-article-extractor

# Use the CMD script as entry point (Act like binary)
ENTRYPOINT ["/proj/vendor/zackslash/php-web-article-extractor/cmd/run.sh"]