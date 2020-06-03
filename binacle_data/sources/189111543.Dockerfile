# credits:
# https://github.com/sensu/sensu-build
# https://github.com/upfluence/sensu-coreos
# https://github.com/docker-library/python/blob/master/2.7/alpine/Dockerfile
FROM ruby:2.3-alpine
MAINTAINER Ory Band @ Rounds <ory@rounds.com>

# configuration environment variables
# see official sensu docs for further info
ENV SENSU_API_BIND=0.0.0.0 \
    SENSU_API_HOST=api \
    SENSU_API_PORT=4567 \

    SENSU_TRANSPORT_NAME=rabbitmq \
    SENSU_TRANSPORT_RECONNECT_ON_ERROR=true \

    SENSU_CLIENT_NAME=sensu-client \
    SENSU_CLIENT_ADDRESS= \
    SENSU_CLIENT_SAFE_MODE=false \
    SENSU_CLIENT_REDACT='"password","passwd","pass","api_key","api_token","access_key","secret_key","private_key","secret"' \
    SENSU_CLIENT_SUBSCRIPTIONS= \
    SENSU_CLIENT_KEEPALIVE_HANDLERS='"default"' \
    SENSU_CLIENT_KEEPALIVE_THRESHOLDS_WARNING=180 \
    SENSU_CLIENT_KEEPALIVE_THRESHOLDS_CRITICAL=300 \
    SENSU_CLIENT_SOCKET_BIND=0.0.0.0 \
    SENSU_CLIENT_SOCKET_PORT=3031 \

    SENSU_RABBITMQ_HOST=rabbitmq \
    SENSU_RABBITMQ_PORT=5672 \
    SENSU_RABBITMQ_VHOST=/sensu \
    SENSU_RABBITMQ_USER=guest \
    SENSU_RABBITMQ_PASSWORD=guest \
    SENSU_RABBITMQ_PREFETCH=1 \
    SENSU_RABBITMQ_SSL_PRIVATE_KEY_FILE= \
    SENSU_RABBITMQ_SSL_CERT_CHAIN_FILE= \

    SENSU_REDIS_HOST=redis \
    SENSU_REDIS_PORT=6379 \
    SENSU_REDIS_PASSWORD=guest \
    SENSU_REDIS_DB=0 \
    SENSU_REDIS_AUTO_RECONNECT=true \
    SENSU_REDIS_RECONNECT_ON_ERROR=false \

    SENSU_LOG_FILE=/dev/stdout \
    SENSU_LOG_LEVEL=warn

# dockerize for configuration templates
ENV DOCKERIZE_VERSION v0.0.3
ENV DOCKERIZE_FILE dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz
ENV DOCKERIZE_URL https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/$DOCKERIZE_FILE

RUN cd /tmp \
    && wget -q $DOCKERIZE_URL \
    && tar -zxf $DOCKERIZE_FILE -C /usr/local/bin \
    && rm $DOCKERIZE_FILE \
    && cd -

# sensu-core and plugin dependencies
RUN apk add -qU --no-cache \
        build-base \
        curl-dev \
        libffi-dev \
        ruby-bundler \
        ruby-dev \
        ruby-io-console \
        # sensu-plugins-aws dependencies
        libxml2-dev \
        libxslt-dev

# sensu dirs
RUN mkdir -p \
        /opt/sensu \
        /etc/sensu/conf.d \
        /etc/sensu/ssl \
        /var/log/sensu/client \
        /var/log/sensu/server \
        /var/log/sensu/api

WORKDIR /opt/sensu

# install sensu-core and ruby plugins
#
# NOTE that when updating Gemfile, you should also add the updated
# Gemfile.lock into the image.
#
# The easiest way to do this is:
#  - build manually
#  - run image with a mount volume
#  - copy the generated Gemfile.lock to your host machine via the volume
#  - git commit Gemfile.lock
#
# this will result in dockerhub building using updated Gemfile.lock,
# instead of having to regenerate it (error prone, slow)
COPY /opt/sensu/Gemfile* /opt/sensu/
# nokogiri is an aws dependency
RUN apk add -qU --no-cache -t .fetch-deps git \
    && bundle config build.nokogiri --use-system-libraries \
    && bundle install --jobs 10 --quiet --without development test \
    && apk del -q .fetch-deps

# configuration template using environment variables
COPY etc/sensu/conf.d/config.json.tmpl /etc/sensu/conf.d/

# api port
EXPOSE 4567

# logs
VOLUME ["/var/log/sensu/client", "/var/log/sensu/server", "/var/log/sensu/api"]

# execute
COPY tmp/entrypoint.sh /tmp/
ENTRYPOINT ["/tmp/entrypoint.sh"]
