#
#--------------------------------------------------------------------------
# Image Setup
#--------------------------------------------------------------------------
#
# To edit the 'workspace' base Image, visit its repository on Github
#    https://github.com/Laradock/workspace
#
# To change its version, see the available Tags on the Docker Hub:
#    https://hub.docker.com/r/laradock/workspace/tags/
#
# Note: Base Image name format {image-tag}-{php-version}
#

FROM laradock/workspace:1.8-56

MAINTAINER Kim Hsiao <white.shopping@gmail.com>

#####################################
# Basic environment:
#####################################

# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ARG PGID=1000

ENV PUID ${PUID}
ENV PGID ${PGID}

RUN groupadd -g ${PGID} laradock && \
    useradd -u ${PUID} -g laradock -m laradock && \
    apt-get update -yqq

#####################################
# Set Timezone
#####################################

ARG TZ=UTC
ENV TZ ${TZ}
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

#####################################
# Install Supervisor:
#####################################

RUN apt-get upgrade -y && \
    apt-get -y install supervisor && \
    groupadd supervisor && \
    usermod -a laradock -G supervisor

#
#--------------------------------------------------------------------------
# Mandatory Software's Installation
#--------------------------------------------------------------------------
#
# Mandatory Software's such as ("php7.1-cli", "git", "vim", ....) are
# installed on the base image 'laradock/workspace' image. If you want
# to add more Software's or remove existing one, you need to edit the
# base image (https://github.com/Laradock/workspace).
#

#
#--------------------------------------------------------------------------
# Optional Software's Installation
#--------------------------------------------------------------------------
#
# Optional Software's will only be installed if you set them to `true`
# in the `docker-compose.yml` before the build.
# Example:
#   - INSTALL_NODE=false
#   - ...
#

#####################################
# SOAP:
#####################################

ARG INSTALL_SOAP=false
ENV INSTALL_SOAP ${INSTALL_SOAP}

RUN if [ ${INSTALL_SOAP} = true ]; then \
  # Install the PHP SOAP extension
  add-apt-repository -y ppa:ondrej/php && \
  apt-get update -yqq && \
  apt-get -y install libxml2-dev php5.6-soap \
;fi

#####################################
# PHP GMP
#####################################

ARG INSTALL_GMP=false
ENV INSTALL_GMP ${INSTALL_GMP}

RUN if [ ${INSTALL_GMP} = true ]; then \
    # Install GMP extension
    apt-get -y install php-gmp \
;fi

#####################################
# xDebug:
#####################################

ARG INSTALL_XDEBUG=false
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
    # Load the xdebug extension only with phpunit commands
    apt-get install -y --force-yes php5.6-xdebug && \
    sed -i 's/^;//g' /etc/php/5.6/cli/conf.d/20-xdebug.ini && \
    echo "alias phpunit='php -dzend_extension=xdebug.so /var/www/vendor/bin/phpunit'" >> ~/.bashrc \
;fi
# ADD for REMOTE debugging
COPY ./xdebug.ini /etc/php/5.6/cli/conf.d/xdebug.ini

#####################################
# MongoDB:
#####################################

# Check if Mongo needs to be installed
ARG INSTALL_MONGO=false
ENV INSTALL_MONGO ${INSTALL_MONGO}
RUN if [ ${INSTALL_MONGO} = true ]; then \
    # Install the mongodb extension
    pecl install mongodb && \
    echo "extension=mongodb.so" >> /etc/php/5.6/cli/conf.d/30-mongodb.ini \
;fi

#####################################
# PHP Aerospike:
#####################################

ARG INSTALL_AEROSPIKE=true
ENV INSTALL_AEROSPIKE ${INSTALL_AEROSPIKE}

# Copy aerospike configration for remote debugging
COPY ./aerospike.ini /etc/php/5.6/cli/conf.d/aerospike.ini

RUN if [ ${INSTALL_AEROSPIKE} = true ]; then \
    # Install the php aerospike extension
    curl -L -o /tmp/aerospike-client-php.tar.gz "https://github.com/aerospike/aerospike-client-php/archive/3.4.14.tar.gz" \
    && mkdir -p aerospike-client-php \
    && tar -C aerospike-client-php -zxvf /tmp/aerospike-client-php.tar.gz --strip 1 \
    && ( \
        cd aerospike-client-php/src/aerospike \
        && phpize \
        && ./build.sh \
        && make install \
    ) \
    && rm /tmp/aerospike-client-php.tar.gz \
;fi

RUN if [ ${INSTALL_AEROSPIKE} = false ]; then \
    rm /etc/php/5.6/cli/conf.d/aerospike.ini \
;fi

#####################################
# MySQL client
#####################################
USER root

ARG INSTALL_MYSQL_CLIENT=false
ENV INSTALL_MYSQL_CLIENT ${INSTALL_MYSQL_CLIENT}

RUN if [ ${INSTALL_MYSQL_CLIENT} = true ]; then \
    apt-get update && \
    apt-get install -y mysql-client \
;fi

#####################################
# PostgreSQL client
#####################################
USER root

ARG INSTALL_PGSQL_CLIENT=false
ENV INSTALL_PGSQL_CLIENT ${INSTALL_PGSQL_CLIENT}

RUN if [ ${INSTALL_PGSQL_CLIENT} = true ]; then \
    apt-get update && \
    apt-get install -y postgresql-client \
;fi

#
#--------------------------------------------------------------------------
# Optional Supervisord Configuration
#--------------------------------------------------------------------------
#
# Modify the ./supervisor.conf file to match your App's requirements.
# Make sure you rebuild your container with every change.
#
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#
#--------------------------------------------------------------------------
# Optional Software's Installation
#--------------------------------------------------------------------------
#
# If you need to modify this image, feel free to do it right here.
#
    # -- Your awesome modifications go here -- #


#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set default work directory
WORKDIR /etc/supervisor/conf.d/

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf", "-n"]
