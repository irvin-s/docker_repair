FROM yoshz/php:5.5
MAINTAINER Yosh de Vos "yosh@elzorro.nl"

# Install base packages
RUN export DEBIAN_FRONTEND="noninteractive" && \
    apt-get update && \
    apt-get -yq upgrade && \
    apt-get -yq install --no-install-recommends \
        apache2 \
        libapache2-mod-php5 && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

# Add apache default vhost configuration
ADD dist/configs/default-vhost.conf /etc/apache2/sites-available/000-default.conf

# Enable apache modules
RUN a2enmod headers php5 rewrite ssl vhost_alias

# Add init script
RUN mkdir /etc/service/apache
ADD dist/services/apache.sh /etc/service/apache/run

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/apache2/access.log && \
    ln -sf /dev/stderr /var/log/apache2/error.log

# Run tests
ADD dist/tests/apache.sh /test.sh
RUN /test.sh && rm /test.sh

EXPOSE 80 443
