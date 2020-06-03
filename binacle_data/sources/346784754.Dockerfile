FROM ubuntu:trusty
MAINTAINER Grafikart <contact@grafikart.fr>

# FIX Apache/PHP write permissions to the app
ENV BOOT2DOCKER_ID 1000
ENV BOOT2DOCKER_GID 50
RUN usermod -u ${BOOT2DOCKER_ID} www-data && \
    usermod -G staff www-data
RUN groupmod -g $(($BOOT2DOCKER_GID + 10000)) $(getent group $BOOT2DOCKER_GID | cut -d: -f1)
RUN groupmod -g ${BOOT2DOCKER_GID} staff

# Install base packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
        imagemagick \
        curl \
        wget \
        apache2 \
        libapache2-mod-php5 \
        php5-mysql \
        php5-gd \
        php5-curl \
        php-pear \
        php5-mcrypt \
        php-apc \
        php5-imagick \
        && \
    rm -rf /var/lib/apt/lists/* && \
    php5enmod mcrypt && \
    a2enmod rewrite && \
    service apache2 stop

# Blackfire
RUN curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/55\
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so `php -r "echo ini_get('extension_dir');"`/blackfire.so \
    && echo "extension=blackfire.so\nblackfire.agent_socket=\${BLACKFIRE_PORT}" > /etc/php5/apache2/conf.d/blackfire.ini

# Apache configuration
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i "s/variables_order.*/variables_order = \"EGPCS\"/g" /etc/php5/apache2/php.ini && \
    sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf

# wkhtmltopdf
RUN apt-get update && \
    apt-get install -y \
        xfonts-utils \
        xfonts-base \
        xfonts-75dpi \
        && \
    wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
    dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb && \
    rm wkhtmltox-0.12.2.1_linux-trusty-amd64.deb

# Add image configuration and scripts
ADD apache.sh /apache.sh
RUN chmod 755 /*.sh

EXPOSE 80

CMD ["/apache.sh"]
