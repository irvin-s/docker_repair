FROM gzevd/alpine:3.4

RUN set -xe; \
  apk add --no-cache --virtual .persistent-deps \
  git \
  sudo \
  rsync \
  curl \
  nano \
  bzip2 \
  ruby \
  php5-cli \
  php5-mcrypt \
  php5-gd \
  php5-curl \
  php5-json \
  php5-phar \
  php5-openssl \
  php5-ctype \
  php5-zip \
  php5-zlib \
  php5-pdo_mysql \
  php5-dom \
  php5-xml \
  nodejs \
  zsh \
  mysql-client \
  openssh-client \
  postgresql-client \
  && echo "date.timezone=Europe/Berlin" >> /etc/php5/php.ini \
  && echo "memory_limit=256M" >> /etc/php5/php.ini \
  && rm -rf /var/cache/* \
  && mkdir -p /var/cache/apk

RUN set -xe; \
  cd /tmp && curl -sSL https://getcomposer.org/installer > composer-setup.php \
  && echo "5a465f56b483df2314cee5dc81a8e877cb607439ebc203963ecaa5e98784bf111f969b5683b5a71560f182403ddddce2f0cda342398c5d41fc46225f82cfdcf2  composer-setup.php" | sha512sum -c - \
  && php composer-setup.php --check \
  && php composer-setup.php --install-dir=/usr/local/bin/ --filename=composer \
  && rm -rf /root/.composer/ \
  && rm -rf /tmp/*

RUN set -xe; \
  cd /tmp && curl -sSL https://drupalconsole.com/installer -o /usr/local/bin/drupal \
  && chmod +x /usr/local/bin/drupal \
  && echo "ecdaf34abfd82bea614c067ce8769194f2e9835553da76da32e1a1a66b8505d99f30b4c9143ae58e5fad21829dba62eb0167e26dba9dac84f58724c045cc273b  /usr/local/bin/drupal" | sha512sum -c -

RUN set -xe; \
  cd /tmp \
	&& curl -sSL https://github.com/drush-ops/drush/releases/download/8.2.3/drush.phar -o /usr/local/bin/drush \
  && chmod +x /usr/local/bin/drush \
  && echo "9299fd086abf4ec050e739a1569448956e750354a29357b49f79afe79983b99b2e5e9ec460f8509e1388bcfee8d70590f5b358d1ec4b88aeb1cf4f9f92cf02f3  /usr/local/bin/drush"  | sha512sum -c -

# Setup dev user
RUN set -xe; \
  adduser dev -s /bin/zsh -D \
  && su dev -c "git clone --quiet --depth=1 https://github.com/zsh-users/antigen.git /home/dev/antigen" \
  && echo 'dev ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers.d/dev \
  && chmod 0440 /etc/sudoers.d/dev

# Fix bug https://github.com/npm/npm/issues/9863
RUN set -xe; \
  cd $(npm root -g)/npm \
  && npm install --no-color --no-progress fs-extra \
  && sed -i -e s/graceful-fs/fs-extra/ -e s/fs\.rename/fs.move/ ./lib/utils/rename.js \
  && npm install --production --no-color --no-progress -g npm yarn gulp-cli \
  && rm -rf /root/.npm

RUN set -xe; \
  apk add --no-cache --virtual .build-deps \
  make \
  g++ \
  ; \
  cd /tmp; \
  export SASSC_VERSION="3.5.0"; \
  export LIBSASS_VERSION="3.5.4"; \
  curl -L https://github.com/sass/sassc/archive/${SASSC_VERSION}.tar.gz | tar -xz; \
  curl -L https://github.com/sass/libsass/archive/${LIBSASS_VERSION}.tar.gz | tar -xz; \
  export SASS_LIBSASS_PATH=`pwd`/libsass-${LIBSASS_VERSION} \
  && echo $SASSC_VERSION > sassc-${SASSC_VERSION}/VERSION \
  && echo $LIBSASS_VERSION > libsass-${LIBSASS_VERSION}/VERSION \
  && make -s -C sassc-${SASSC_VERSION} \
  && make install -C sassc-${SASSC_VERSION} \
  && sassc --version \
  && rm -rf /tmp/* \
  && apk del --no-cache .build-deps

COPY .zshrc /home/dev/.zshrc

RUN set -xe; \
    chown dev: /home/dev/.zshrc \
    && su dev -c "source /home/dev/.zshrc" \
    && find /home/dev/ -type d -name \.git -exec rm -rf -- {} +

COPY .gemrc /etc/gemrc
RUN set -xe; \
    export CONFIGURE_OPTS="--disable-install-doc"; \
    apk add --no-cache \
    gmp \
    yaml \
    ruby-json \
    ruby-bigdecimal \
    && apk add --no-cache --virtual .build-deps \
    ruby-dev \
    build-base \
    openssl-dev \
    && gem update --clear-sources --quiet --system 2.7.9 \
    && gem update --clear-sources --quiet --force \
    && gem install --clear-sources --quiet compass jekyll \
    && gem cleanup \
    && apk del --no-cache .build-deps \
    && rm -rf /tmp/* \
    && rm -rf /home/root/.gem/
