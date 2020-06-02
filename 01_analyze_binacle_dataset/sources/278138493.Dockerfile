FROM alpine:3.7

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1
ENV JEYKLL_ENV=prod

RUN apk update \
    && \
    apk add ruby \
            ruby-bigdecimal \
            ruby-bundler \
            ruby-io-console \
            ruby-irb \
            ca-certificates \
            libressl \
    && \
    apk add --virtual \
            build-dependencies \
            build-base \
            ruby-dev \
            libressl-dev \
    && \
    bundle config build.nokogiri --use-system-libraries \
    && \
    bundle config git.allow_insecure true \
    && \
    gem install json --no-rdoc --no-ri \
    && \
    gem cleanup \
    && \
    apk del build-dependencies \
    && \
    rm -rf /usr/lib/ruby/gems/*/cache/* \
          /var/cache/apk/* \
          /tmp/* \
          /var/tmp/*
RUN mkdir /srv/www
COPY ./ /srv/www/
RUN cd /srv/www && bundle exec jekyll build
