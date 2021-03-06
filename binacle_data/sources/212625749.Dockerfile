FROM mhart/alpine-node:latest

## ruby alpine docker hub library

# skip installing gem documentation
RUN mkdir -p /usr/local/etc \
  && { \
    echo 'install: --no-document'; \
    echo 'update: --no-document'; \
  } >> /usr/local/etc/gemrc

ENV RUBY_MAJOR 2.2
ENV RUBY_VERSION 2.2.10
ENV RUBY_DOWNLOAD_SHA512 051124922240d2e20e74903b9c629fa897279072d2aa9b0a4e3a02331b843fa9c97c16e7073d6faec1b9f2024c3a7e36346014c30eee256f0715c5de226b5db8
ENV RUBYGEMS_VERSION 2.6.13

# some of ruby's build scripts are written in ruby
# we purge this later to make sure our final image uses what we just built
RUN set -ex \
  && apk add --no-cache --virtual .ruby-builddeps \
    autoconf \
    bison \
    bzip2 \
    bzip2-dev \
    ca-certificates \
    coreutils \
    curl \
    gcc \
    gdbm-dev \
    glib-dev \
    libc-dev \
    libffi-dev \
    libxml2-dev \
    libxslt-dev \
    linux-headers \
    make \
    ncurses-dev \
    libressl-dev \
    procps \
# https://bugs.ruby-lang.org/issues/11869 and https://github.com/docker-library/ruby/issues/75
    readline-dev \
    ruby \
    yaml-dev \
    zlib-dev \
  && curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
  && echo "$RUBY_DOWNLOAD_SHA512 *ruby.tar.gz" | sha512sum -c - \
  && mkdir -p /usr/src \
  && tar -xzf ruby.tar.gz -C /usr/src \
  && mv "/usr/src/ruby-$RUBY_VERSION" /usr/src/ruby \
  && rm ruby.tar.gz \
  && cd /usr/src/ruby \
  && { echo '#define ENABLE_PATH_CHECK 0'; echo; cat file.c; } > file.c.new && mv file.c.new file.c \
  && autoconf \
  # the configure script does not detect isnan/isinf as macros
  && ac_cv_func_isnan=yes ac_cv_func_isinf=yes \
    ./configure --disable-install-doc \
  && make -j"$(getconf _NPROCESSORS_ONLN)" \
  && make install \
  && runDeps="$( \
    scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
  )" \
  && apk add --virtual .ruby-rundeps $runDeps \
    bzip2 \
    ca-certificates \
    curl \
    libffi-dev \
    libressl-dev \
    yaml-dev \
    procps \
    zlib-dev \
  && apk del .ruby-builddeps \
  && gem update --system $RUBYGEMS_VERSION \
  && rm -r /usr/src/ruby

ENV BUNDLER_VERSION 1.15.4

RUN gem install bundler --version "$BUNDLER_VERSION"

# install things globally, for great justice
# and don't create ".bundle" in all our apps
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="$GEM_HOME" \
  BUNDLE_BIN="$GEM_HOME/bin" \
  BUNDLE_SILENCE_ROOT_WARNING=1 \
  BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p "$GEM_HOME" "$BUNDLE_BIN" \
  && chmod 777 "$GEM_HOME" "$BUNDLE_BIN"

