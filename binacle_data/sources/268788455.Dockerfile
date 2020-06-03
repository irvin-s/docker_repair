FROM ruby:2.3-alpine as builder

ARG APP_DIR=/webapp
ARG BUILD_PKGS="ruby-dev openssl-dev gcc make libc-dev binutils"

ENV GEM_HOME=${APP_DIR}/vendor/gems
ENV BUNDLE_PATH=${APP_DIR}/vendor/gems
ENV BUNDLE_APP_CONFIG=${APP_DIR}/vendor/gems/.bundle
ENV BUNDLE_DISABLE_SHARED_GEMS=true

RUN mkdir -p ${APP_DIR}/vendor

WORKDIR ${APP_DIR}
ADD Gemfile* ${APP_DIR}/
RUN apk add -U ${BUILD_PKGS} && \
        bundle install && \
        apk del ${BUILD_PKGS} && \
        rm -rf /var/cache/apk/*

# Doing a multi-stage build to reset some stuff for a smaller image
FROM ruby:2.3-alpine

ARG APP_DIR=/webapp
WORKDIR ${APP_DIR}

COPY --from=builder ${APP_DIR} .

ENV GEM_HOME=${APP_DIR}/vendor/gems
ENV BUNDLE_PATH=${APP_DIR}/vendor/gems
ENV BUNDLE_APP_CONFIG=${APP_DIR}/vendor/gems/.bundle
ENV BUNDLE_DISABLE_SHARED_GEMS=true

ADD app.rb ${APP_DIR}/
ADD monkeys.txt ${APP_DIR}/
ADD config.ru ${APP_DIR}/
ADD lib ${APP_DIR}/lib
ADD views ${APP_DIR}/views
ADD assets ${APP_DIR}/assets

ADD plugins.yaml ${APP_DIR}/

CMD bundle exec puma
