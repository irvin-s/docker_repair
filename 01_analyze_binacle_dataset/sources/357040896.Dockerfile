# StatsD

FROM ennexa/base

# This suppresses a bunch of annoying warnings from debconf
ENV DEBIAN_FRONTEND noninteractive

# Install system dependencies
RUN \
  wget -qO - https://deb.nodesource.com/setup_4.x | bash - && \
  apt-get -qq update -y && \
  apt-get -qq install -y nodejs unzip && \
  apt-get -qq clean -y && rm -rf /var/lib/apt/lists/*

# Install StatsD
RUN \
  mkdir -p /opt && \
  cd /opt && \
  wget -qO statsd.zip https://github.com/etsy/statsd/archive/master.zip && \
  unzip statsd.zip && \
  mv statsd-master statsd && \
  rm -f statsd.zip

# StatsD
COPY conf/config.js /etc/statsd/config.js

EXPOSE \
  # StatsD UDP
  8125/udp \
  # StatsD Admin
  8126

VOLUME ["/etc/statsd"]

# Launch StatsD
CMD ["/usr/bin/node", "/opt/statsd/stats.js", "/etc/statsd/config.js"]
