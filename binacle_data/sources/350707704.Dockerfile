FROM yoshz/php:5.5
MAINTAINER Yosh de Vos "yosh@elzorro.nl"

# Install base packages
RUN export DEBIAN_FRONTEND="noninteractive" && \
    apt-get update && \
    apt-get -yq install --no-install-recommends \
        php5-fpm && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# Configure php-fpm
RUN sed -i 's/^listen .*/listen = 0.0.0.0:9000/' /etc/php5/fpm/pool.d/www.conf

# Add init script
RUN mkdir /etc/service/php-fpm
ADD php-fpm.sh /etc/service/php-fpm/run

# Run tests
ADD test.sh /test.sh
RUN /test.sh && rm /test.sh

EXPOSE 9000
