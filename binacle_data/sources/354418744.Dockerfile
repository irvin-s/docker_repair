################################################################################
# Base image
################################################################################

FROM nginx:1.9

################################################################################
# Environment variables
################################################################################

ARG VANILLA_VERSION
ARG VANILLA_URL

################################################################################
# Build instructions
################################################################################

USER root

# Remove default nginx configs.
RUN rm -f /etc/nginx/conf.d/*

# Copy nginx configs to container.
COPY config/nginx.conf /etc/nginx/
COPY config/server.conf /etc/nginx/conf.d/

# Install Supervisor and copy config.
RUN apt-get update && apt-get install -y supervisor
COPY config/supervisor.conf /etc/supervisor/conf.d/

# Install git.
RUN apt-get install -y git-core

# Install PHP5 FPM and copy configs.
RUN apt-get install -y php5-fpm
COPY config/php.ini /etc/php5/fpm/conf.d/
COPY config/php5-fpm.conf /etc/php5/fpm/pool.d/

# Ensure that PHP5 FPM is run as root.
RUN sed -i "s/user = www-data/user = root/" /etc/php5/fpm/pool.d/www.conf
RUN sed -i "s/group = www-data/group = root/" /etc/php5/fpm/pool.d/www.conf

# Install PHP modules.
RUN apt-get install -y \
  php5-curl \
  php5-gd \
  php5-memcached \
  php5-mysql

WORKDIR /var/www

# Install Vanilla.
RUN git clone -b Vanilla_$VANILLA_VERSION --depth 1 $VANILLA_URL .

# Set correct folder permissions.
RUN chmod 777 conf
RUN chmod 777 cache

# Copy applications, plugins, themes, and locales to Vanilla.
COPY applications/ applications/
COPY plugins/ plugins/
COPY themes/ themes/
COPY locales/ locales/

################################################################################
# Volumes
################################################################################

# Expose writeable folders as volumes.
VOLUME "/var/www/conf/"
VOLUME "/var/www/uploads/"

# Expose logging volumes.
VOLUME "/var/log/nginx/"
VOLUME "/var/log/php5-fpm/"

################################################################################
# Entrypoint
################################################################################

ENTRYPOINT ["/usr/bin/supervisord"]
