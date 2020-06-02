# vim: ft=dockerfile
FROM alpine:3.6

ENV RUBY_MAJOR "2.4"
ENV RUBY_VERSION "2.4.2"
ENV RUBY_DOWNLOAD_SHA256 "748a8980d30141bd1a4124e11745bb105b436fb1890826e0d2b9ea31af27f735"
ENV RUBYGEMS_VERSION "2.6.14"
ENV BUNDLER_VERSION "1.16.0"

# skip installing gem documentation
RUN mkdir -p /usr/local/etc \
  && { \
    echo 'install: --no-document'; \
    echo 'update: --no-document'; \
  } >> /usr/local/etc/gemrc


# some of ruby's build scripts are written in ruby
#   we purge system ruby later to make sure our final image uses what we just built
# readline-dev vs libedit-dev: https://bugs.ruby-lang.org/issues/11869 and https://github.com/docker-library/ruby/issues/75
RUN set -ex \
  && apk add --no-cache --virtual .ruby-builddeps \
    autoconf \
    bison \
    bzip2 \
    bzip2-dev \
    ca-certificates \
    coreutils \
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
    libressl \
    libressl-dev \
    procps \
    readline-dev \
    ruby \
    tar \
    yaml-dev \
    zlib-dev \
    xz \
  && wget -O ruby.tar.xz "https://cache.ruby-lang.org/pub/ruby/${RUBY_MAJOR%-rc}/ruby-2.4.2.tar.xz" \
  && echo "748a8980d30141bd1a4124e11745bb105b436fb1890826e0d2b9ea31af27f735 *ruby.tar.xz" | sha256sum -c - \
  && mkdir -p /usr/src/ruby \
  && tar -xJf ruby.tar.xz -C /usr/src/ruby --strip-components=1 \
  && rm ruby.tar.xz \
  && cd /usr/src/ruby \
  && { \
    echo '#define ENABLE_PATH_CHECK 0'; \
    echo; \
    cat file.c; \
  } > file.c.new \
  && mv file.c.new file.c \
  && autoconf \
  && ac_cv_func_isnan=yes ac_cv_func_isinf=yes \
    ./configure --disable-install-doc --enable-shared \
  && make -j"$(getconf _NPROCESSORS_ONLN)" \
  && make install \
  && runDeps="$( \
    scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
  )" \
  && apk add --virtual .ruby-rundeps  \
    bzip2 \
    ca-certificates \
    libffi-dev \
    libressl-dev \
    yaml-dev \
    procps \
    zlib-dev \
  && apk del .ruby-builddeps \
  && cd / \
  && rm -r /usr/src/ruby \
  && gem update --system "2.6.14"

RUN gem install bundler --version "1.16.0"
