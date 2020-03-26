FROM yoshz/apache-php:5.5
MAINTAINER Yosh de Vos "yosh@elzorro.nl"

# Install base packages
RUN export DEBIAN_FRONTEND="noninteractive" && \
    apt-get update && \
    apt-get -yq upgrade && \
    apt-get -yq install --no-install-recommends \
        php5-xdebug && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# Display php errors
RUN sed -i -e 's/^display_errors.*$/display_errors = On/' /etc/php5/*/php.ini

# Install and enable xdebug
ADD dist/configs/xdebug.ini /etc/php/5.5/apache2/conf.d/20-xdebug.ini
RUN rm /etc/php5/cli/conf.d/20-xdebug.ini && \
    echo "xdebug.max_nesting_level=500" > /etc/php5/cli/conf.d/20-xdebug.ini && \
    echo "alias php='php -dzend_extension=xdebug.so'\nalias phpunit='php /usr/local/bin/phpunit'" >> /etc/bash.bashrc

# Install development tools
ADD dist/scripts/install-dev-tools.sh /install-dev-tools.sh
RUN /install-dev-tools.sh && rm /install-dev-tools.sh

# Configure git
ADD dist/configs/gitconfig /etc/gitconfig

# Configure ssh
RUN rm -f /etc/service/sshd/down
ADD dist/ssh/* /etc/ssh/

# Run tests
ADD dist/tests/dev-tools.sh /test.sh
RUN /test.sh && rm /test.sh

# Add entrypoint script
ADD dist/scripts/dev-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/sbin/my_init"]

# Expose ssh and livereload
EXPOSE 22 35729

WORKDIR /var/www
