FROM mgreenly/debian:latest

RUN RUBY_MAJOR=2.4 \
    RUBY_VERSION=2.4.0 \
    RUBY_SHA256=152fd0bd15a90b4a18213448f485d4b53e9f7662e1508190aa5b702446b29e3d \
    RUBYGEMS_VERSION=2.6.12 \
    BUNDLER_VERSION=1.15.1 \
    && cd /tmp \
    && curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
    && echo "$RUBY_SHA256 ruby.tar.gz" | sha256sum -c - \
    && tar -xvf ruby.tar.gz \
    && cd /tmp/ruby-$RUBY_VERSION \
    && autoconf \
    && ./configure --disable-install-doc \
    && make -j"$(nproc)" \
    && make install \
    && echo 'install: --no-document\nupdate: --no-document' >> "$HOME/.gemrc" \
    && echo 'install: --no-document\nupdate: --no-document' >> "/etc/skel/.gemrc" \
    && gem update --system $RUBY_GEMS_VERSION \
    && gem install --no-document bundler \
    && rm -rf /tmp/ruby*
