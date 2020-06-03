FROM alpine:3.6

MAINTAINER Alessandro Molari <molari.alessandro@gmail.com> (alem0lars)

# ────────────────────────────────────────────── Setup basic system packages ──┐

RUN apk update \
 && apk upgrade

# Install libraries.
RUN apk add --update --no-cache \
    linux-headers build-base openssl-dev libc-dev libxml2-dev libxslt-dev \
    libffi-dev readline-dev jemalloc-dev \
    g++ musl-dev make

# Install programs.
RUN apk add --update --no-cache \
    git bash curl wget zsh

# ─────────────────────────────────────────────────────────────────────────────┘

# ─────────────────────────────────────── Setup common environment variables ──┐

ENV HOME /root

# ─────────────────────────────────────────────────────────────────────────────┘

# ─────────────────────────────────────────────────────────── Setup ruby (1) ──┐

ARG RUBY_MAJOR=2
ARG RUBY_MINOR=4
ARG RUBY_PATCH=0
ARG RUBY_OTHER=
ARG RUBY_SHA256=152fd0bd15a90b4a18213448f485d4b53e9f7662e1508190aa5b702446b29e3d
ARG RUBYGEMS_FULL_VERSION=2.6.12

ENV RUBY_VERSION ${RUBY_MAJOR}.${RUBY_MINOR}
ENV RUBY_FULL_VERSION ${RUBY_VERSION}.${RUBY_PATCH}${RUBY_OTHER}

# skip installing gem documentation
RUN mkdir -p /usr/local/etc \
  && { \
    echo 'install: --no-document'; \
    echo 'update: --no-document'; \
  } >> /usr/local/etc/gemrc

# some of ruby's build scripts are written in ruby
#   we purge system ruby later to make sure our final image uses what we just built
# readline-dev vs libedit-dev: https://bugs.ruby-lang.org/issues/11869 and https://github.com/docker-library/ruby/issues/75
RUN apk add --no-cache --virtual .ruby-builddeps \
    autoconf \
    bison \
    bzip2 \
    bzip2-dev \
    ca-certificates \
    coreutils \
    dpkg-dev dpkg \
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
    openssl \
    openssl-dev \
    procps \
    readline-dev \
    ruby \
    tar \
    yaml-dev \
    zlib-dev \
    xz
RUN set -ex \
  && wget -O ruby.tar.gz "https://cache.ruby-lang.org/pub/ruby/${RUBY_VERSION}/ruby-$RUBY_FULL_VERSION.tar.gz" \
  && echo "$RUBY_SHA256 *ruby.tar.gz" | sha256sum -c - \
  && mkdir -p /usr/src/ruby \
  && tar -xf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
  && rm ruby.tar.gz \
  && cd /usr/src/ruby \
  # XXX hack in "ENABLE_PATH_CHECK" disabling to suppress:
  #   warning: Insecure world writable dir
  && { \
    echo '#define ENABLE_PATH_CHECK 0'; \
    echo; \
    cat file.c; \
  } > file.c.new \
  && mv file.c.new file.c \
  && autoconf \
  && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
  # the configure script does not detect isnan/isinf as macros
  && export ac_cv_func_isnan=yes ac_cv_func_isinf=yes \
  && ./configure \
    --build="$gnuArch" \
    --disable-install-doc \
    --enable-shared \
  && make -j "$(nproc)" \
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
    libffi-dev \
    openssl-dev \
    yaml-dev \
    procps \
    zlib-dev \
  && apk del .ruby-builddeps \
  && cd / \
  && rm -r /usr/src/ruby \
  && gem update --system "$RUBYGEMS_FULL_VERSION"

# ─────────────────────────────────────────────────────────────────────────────┘

# ─────────────────────────────────────────────────────────── Setup ruby (2) ──┐

# Install bundler.
RUN gem install bundler

# Install things globally and don't create `.bundle` in all our apps.
ENV GEM_HOME /usr/local/bundle
ENV BUNDLE_PATH="${GEM_HOME}"                                                  \
    BUNDLE_BIN="${GEM_HOME}/bin"                                               \
    BUNDLE_SILENCE_ROOT_WARNING=1                                              \
    BUNDLE_APP_CONFIG="$GEM_HOME"
ENV PATH $BUNDLE_BIN:$PATH
RUN mkdir -p  "${GEM_HOME}" "${BUNDLE_BIN}"                                    \
 && chmod 777 "${GEM_HOME}" "${BUNDLE_BIN}"

# ─────────────────────────────────────────────────────────────────────────────┘

# ──────────────────────────────────────────────────────────────── Setup ssh ──┐

# Install ssh daemon.
RUN apk add --update --no-cache                                                \
    openssh

# Generate fresh keys.
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa                       \
 && ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa

# Prepare ssh run directory.
RUN mkdir -p /var/run/sshd

# Configure ssh.
RUN echo "StrictHostKeyChecking=no" >> /etc/ssh/ssh_config
RUN sed -i 's|[#]*PasswordAuthentication yes|PasswordAuthentication no|g'      \
    /etc/ssh/sshd_config

# Expose ssh port.
EXPOSE 22

# ─────────────────────────────────────────────────────────────────────────────┘

# ──────────────────────────────────────────────────────────────── Setup git ──┐

ENV GIT_PWD="git"
ENV GIT_USER="git"
ENV GIT_GROUP="git"
ENV GIT_REPOS_DIR="/git"

# Install git packages.
RUN apk add --update --no-cache                                                \
    git-daemon                                                                 \
    git

# Setup a git user and ssh.
RUN addgroup "${GIT_GROUP}"                                                    \
 && echo -e "${GIT_PWD}\n${GIT_PWD}\n"                                         \
  | adduser -G "${GIT_GROUP}" -h "${GIT_REPOS_DIR}" -s /usr/bin/git-shell "${GIT_USER}"

# Remove the annoying `/etc/motd`.
RUN rm -rf /etc/update-motd.d /etc/motd /etc/motd.dynamic
RUN ln -fs /dev/null /run/motd.dynamic

# Configure local git client.
# TODO: Replace with fizzy config (when `--no-ask` is implemented).
RUN git config --global push.default simple                                    \
 && git config --global user.name  root                                        \
 && git config --global user.email root@localhost.localdomain

# SSH keys for user `root`
ADD docker/ssh_key.pub "/root/.ssh/authorized_keys"
ADD docker/ssh_key.pub "/root/.ssh/id_rsa.pub"
ADD docker/ssh_key     "/root/.ssh/id_rsa"
RUN chmod 700 "/root/.ssh"
RUN chmod 600 /root/.ssh/*

# SSH keys for user `git`
ADD docker/ssh_key.pub "${GIT_REPOS_DIR}/.ssh/authorized_keys"
ADD docker/ssh_key.pub "${GIT_REPOS_DIR}/.ssh/id_rsa.pub"
ADD docker/ssh_key     "${GIT_REPOS_DIR}/.ssh/id_rsa"
RUN chmod 700 "${GIT_REPOS_DIR}/.ssh"
RUN chmod 600 ${GIT_REPOS_DIR}/.ssh/*
RUN chown -R "${GIT_USER}:${GIT_GROUP}" "${GIT_REPOS_DIR}/.ssh"

# ─────────────────────────────────────────────────────────────────────────────┘

# ────────────────────────────────────────────────────────────── Setup fizzy ──┐

# Install fizzy dependencies.
RUN gem install thor
RUN apk add --update --no-cache                                                \
    sudo

# Install fizzy.
# TODO: change back to branch `master`.
RUN curl -sL                                                                   \
    https://raw.githubusercontent.com/alem0lars/fizzy/develop/build/fizzy      \
  | tee /usr/local/bin/fizzy > /dev/null                                       \
 && chmod +x /usr/local/bin/fizzy

# ─────────────────────────────────────────────────────────────────────────────┘

# ─────────────────────────────────────────────────────────── Setup ruby (3) ──┐

RUN fizzy cfg s -C ruby -U https:alem0lars/configs-ruby
RUN fizzy qi -V docker-test-box -C ruby -I ruby

# ─────────────────────────────────────────────────────────────────────────────┘

# ──────────────────────────────────────────────────────────── Setup rsyslog ──┐

RUN apk add --update --no-cache rsyslog

ADD docker/rsyslog.conf /etc/rsyslog.d/90-fizzy.conf

# ─────────────────────────────────────────────────────────────────────────────┘

# ──────────────────────────────────────────────────────── Setup supervisord ──┐

RUN apk add --update --no-cache supervisor

ADD docker/supervisord.ini /etc/supervisor.d/supervisord.ini

# ─────────────────────────────────────────────────────────────────────────────┘

# ──────────────────────────────────────────────────────────────── Setup app ──┐

ENV APP_DIR="${HOME}/fizzy"

# ──────────────────────────── (trick to allow caching) Install dependencies ──┤

WORKDIR /tmp
ADD ./Gemfile      Gemfile
ADD ./Gemfile.lock Gemfile.lock
RUN bundle install --without website
RUN rm ./Gemfile                                                               \
 && rm ./Gemfile.lock

# ────────────────────────────────────────────────────────────── Add the app ──┤

ADD . "${APP_DIR}"
WORKDIR "${APP_DIR}"
RUN bundle install --without website
RUN bundle exec rake build

# ─────────────────────────────────────────────────────────────────────────────┘

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
