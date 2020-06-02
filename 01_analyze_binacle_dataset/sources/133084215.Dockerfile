FROM fluent/fluentd:v1.1.3-debian
ARG RUBY_URL
ARG MIRROR_DEBIAN
ARG PLUGIN_VERSION
COPY Gemfile /Gemfile
COPY fluent-plugin-swift-$PLUGIN_VERSION.gem /
RUN buildDeps="sudo make gcc g++ libc-dev ruby-dev build-essential zlib1g-dev liblzma-dev" ; \
    runDeps="net-tools" ; \
    echo "$http_proxy $no_proxy" && set -x && [ -z "$MIRROR_DEBIAN" ] || \
     sed -i.orig -e "s|http://deb.debian.org\([^[:space:]]*\)|$MIRROR_DEBIAN/debian9|g ; s|http://security.debian.org\([^[:space:]]*\)|$MIRROR_DEBIAN/debian9-security|g" /etc/apt/sources.list ; \
  apt-get update -qq && \
    apt-get install -y --no-install-recommends $buildDeps $runDeps && \
    ( set -ex ; echo 'gem: --no-document' >> /etc/gemrc && \
    [ -z "$http_proxy" ] || gem_proxy=" -p $http_proxy " ; \
    [ -z "$http_proxy" ] || gem_args=" $gem_args -r $gem_proxy " ; \
    [ -z "$RUBY_URL" ] || sudo -E gem source -r https://rubygems.org/ ; \
    [ -z "$RUBY_URL" ] || sudo -E gem source -a $RUBY_URL ; \
    [ -z "$RUBY_URL" ] || sudo -E gem source -c ; \
    sudo -E gem sources ; \
    cp /fluent-plugin-swift-$PLUGIN_VERSION.gem /var/lib/gems/2.3.0/cache/ ; \
    sudo -E gem install -V --file /Gemfile --no-rdoc --no-ri $gem_args  ; \
    sudo -E gem install -V --no-rdoc --no-ri $gem_proxy /fluent-plugin-swift-$PLUGIN_VERSION.gem  ; \
    ) \
 && sudo -E gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
           /home/fluent/.gem/ruby/2.3.0/cache/*.gem

