FROM mkaag/baseimage:latest
MAINTAINER Maurice Kaag <mkaag@me.com>

# -----------------------------------------------------------------------------
# Environment variables
# -----------------------------------------------------------------------------
ENV CONFD_VERSION 0.11.0

# -----------------------------------------------------------------------------
# Pre-install
# -----------------------------------------------------------------------------
RUN \
    sed -i 's/^# \(.*-backports\s\)/\1/g' /etc/apt/sources.list && \
    echo 'deb http://ppa.launchpad.net/vbernat/haproxy-1.5/ubuntu trusty main' >> /etc/apt/sources.list; \
    echo 'deb-src http://ppa.launchpad.net/vbernat/haproxy-1.5/ubuntu trusty main' >> /etc/apt/sources.list; \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 505D97A41C61B9CD; \
    apt-get update -qqy

# -----------------------------------------------------------------------------
# Install
# -----------------------------------------------------------------------------
RUN \
    apt-get install -qqy --no-install-recommends haproxy; \
    touch /var/log/haproxy.log; \
    chown haproxy: /var/log/haproxy.log

# -----------------------------------------------------------------------------
# Post-install
# -----------------------------------------------------------------------------
ADD build/syslog-ng.conf /etc/syslog-ng/conf.d/haproxy.conf
ADD build/haproxy.toml /etc/confd/conf.d/haproxy.toml
ADD build/haproxy.tmpl /etc/confd/templates/haproxy.tmpl

WORKDIR /usr/local/bin
RUN \
    curl -s -L https://github.com/kelseyhightower/confd/releases/download/v$CONFD_VERSION/confd-$CONFD_VERSION-linux-amd64 -o confd; \
    chmod +x confd

RUN mkdir /etc/service/haproxy
ADD build/haproxy.sh /etc/service/haproxy/run
RUN chmod +x /etc/service/haproxy/run

EXPOSE 80 443 1936
VOLUME ["/etc/ssl"]

CMD ["/sbin/my_init"]

# -----------------------------------------------------------------------------
# Clean up
# -----------------------------------------------------------------------------
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
