FROM ubuntu:trusty

# Install base packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -yq install \
        curl \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-gd \
        php5-curl \
        php-pear \
		php5-cli \
		php5-json \
        php-apc && \
    rm -rf /var/lib/apt/lists/*
RUN sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN for f in /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/000-default.conf ; \
	do \
		sed -i 's%\${APACHE_LOG_DIR}/access.log combined%/dev/stdout combined%' $f ; \
		sed -i 's%\${APACHE_LOG_DIR}/error.log%/dev/stdout%' $f ; \
	done

# Add image configuration and scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh
EXPOSE 80

# Configure /app folder with sample app
RUN mkdir -p /app && rm -fr /var/www/html && ln -s /app /var/www/html
ADD sample/ /app

CMD /run.sh

ONBUILD RUN rm -fr /var/www/html /app