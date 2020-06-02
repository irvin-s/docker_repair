FROM ruby:2.5.0-alpine3.7

ARG UID=991
ARG GID=991

ENV RAILS_SERVE_STATIC_FILES=true \
    RAILS_ENV=development NODE_ENV=development \
    LOCAL_HTTPS=false

ARG YARN_VERSION=1.3.2
ARG YARN_DOWNLOAD_SHA256=6cfe82e530ef0837212f13e45c1565ba53f5199eec2527b85ecbcd88bf26821d
ARG LIBICONV_VERSION=1.15
ARG LIBICONV_DOWNLOAD_SHA256=ccf536620a45458d26ba83887a983b96827001e92a13847b45e4925cc8913178

EXPOSE 3000 4000

WORKDIR /mastodon

RUN apk -U upgrade \
 && apk add -t build-dependencies \
    build-base \
    icu-dev \
    libidn-dev \
    libressl \
    libtool \
    postgresql-dev \
    protobuf-dev \
    python \
 && apk add \
    ca-certificates \
    ffmpeg \
    file \
    git \
    icu-libs \
    imagemagick \
    libidn \
    libpq \
    nodejs \
    nodejs-npm \
    protobuf \
    su-exec \
    tini \
    tzdata \
 && update-ca-certificates \
 && mkdir -p /tmp/src /opt \
 && wget -O yarn.tar.gz "https://github.com/yarnpkg/yarn/releases/download/v$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
 && echo "$YARN_DOWNLOAD_SHA256 *yarn.tar.gz" | sha256sum -c - \
 && tar -xzf yarn.tar.gz -C /tmp/src \
 && rm yarn.tar.gz \
 && mv /tmp/src/yarn-v$YARN_VERSION /opt/yarn \
 && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
 && wget -O libiconv.tar.gz "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-$LIBICONV_VERSION.tar.gz" \
 && echo "$LIBICONV_DOWNLOAD_SHA256 *libiconv.tar.gz" | sha256sum -c - \
 && tar -xzf libiconv.tar.gz -C /tmp/src \
 && rm libiconv.tar.gz \
 && cd /tmp/src/libiconv-$LIBICONV_VERSION \
 && ./configure --prefix=/usr/local \
 && make -j$(getconf _NPROCESSORS_ONLN)\
 && make install \
 && libtool --finish /usr/local/lib \
 && cd /mastodon \
 && rm -rf /tmp/* /var/cache/apk/*

RUN addgroup -g ${GID} mastodon && adduser -h /mastodon -s /bin/sh -D -G mastodon -u ${UID} mastodon

RUN git clone https://github.com/tootsuite/mastodon.git /mastodon
RUN chown -R mastodon:mastodon /mastodon

USER mastodon
RUN bundle config build.nokogiri --with-iconv-lib=/usr/local/lib --with-iconv-include=/usr/local/include
RUN bundle install --without test
RUN yarn install --pure-lockfile

# XXX workaround for ruby goldfinger gem
# adds the ability to search profiles via http
# (see https://github.com/tootsuite/goldfinger/pull/2)
RUN sed -i 's/https/http/' \
  /usr/local/bundle/gems/goldfinger-*/lib/goldfinger/client.rb

# XXX disable redis; redis received all jobs but
# didn't execute them. bypassing it now till
# someone with more knowledge comes around
RUN echo -e "if Rails.env.development?\n"\
  "require 'sidekiq/testing'\n"\
  "Sidekiq::Testing.inline!\n"\
  "end" >> config/initializers/sidekiq.rb

COPY .env /mastodon/.env
COPY start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]
