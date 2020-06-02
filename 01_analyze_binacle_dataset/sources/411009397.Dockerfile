FROM alpine:3.2
MAINTAINER  Robert Reiz <reiz@versioneye.com>

ENV RAILS_ENV test
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8

ENV BUILD_PACKAGES bash curl-dev ruby-dev build-base libxml2-dev libxslt-dev libffi-dev
ENV RUBY_PACKAGES ruby ruby-io-console ruby-bundler

# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add openssh git && \
    apk add $BUILD_PACKAGES && \
    apk add $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN rm -Rf /app; mkdir -p /app; mkdir -p /app/log; mkdir -p /app/pids
COPY Gemfile Gemfile.lock /app/
RUN cd /app && \
    gem install bundler --no-rdoc --version 1.10.6 && \
    bundle config build.nokogiri --use-system-libraries && \
    bundle install
