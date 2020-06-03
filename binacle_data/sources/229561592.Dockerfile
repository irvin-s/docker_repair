FROM quay.io/deis/base:v0.3.6

COPY . /

RUN buildDeps='g++ gcc make ruby-dev'; \
    apt-get update && \
    apt-get install -y \
        $buildDeps \
        ruby && \
    export FLUENTD_VERSION=0.14.13 && \
    gem install --no-document fluentd -v $FLUENTD_VERSION && \
    gem install bundler && \
    bundle install --gemfile=/opt/fluentd/deis-output/Gemfile && \
    rake --rakefile=/opt/fluentd/deis-output/Rakefile build && \
    fluent-gem install --no-document fluent-plugin-kubernetes_metadata_filter -v 0.25.3  && \
    fluent-gem install --no-document fluent-plugin-elasticsearch -v 1.7.0 && \
    fluent-gem install --no-document fluent-plugin-remote_syslog -v 0.3.2 && \
    fluent-gem install --no-document fluent-plugin-sumologic-mattk42 -v 0.0.4 && \
    fluent-gem install --no-document fluent-plugin-gelf-hs -v 1.0.4 && \
    fluent-gem install --no-document influxdb -v 0.3.2 && \
    fluent-gem install --no-document nsq-ruby -v 1.7.0 && \
    fluent-gem install --local /opt/fluentd/deis-output/pkg/fluent-plugin-deis_output-0.1.0.gem && \
    # cleanup
    apt-get purge -y --auto-remove $buildDeps && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    # package up license files if any by appending to existing tar
    COPYRIGHT_TAR='/usr/share/copyrights.tar'; \
    gunzip -f $COPYRIGHT_TAR.gz; tar -rf $COPYRIGHT_TAR /usr/share/doc/*/copyright; gzip $COPYRIGHT_TAR && \
    rm -rf \
        /usr/share/doc \
        /usr/share/man \
        /usr/share/info \
        /usr/share/locale \
        /var/lib/apt/lists/* \
        /var/log/* \
        /var/cache/debconf/* \
        /etc/systemd \
        /lib/lsb \
        /lib/udev \
        /usr/lib/x86_64-linux-gnu/gconv/IBM* \
        /usr/lib/x86_64-linux-gnu/gconv/EBC* && \
    bash -c "mkdir -p /usr/share/man/man{1..8}"

COPY /var /var

CMD ["/opt/fluentd/sbin/boot"]
