FROM phusion/baseimage:0.9.18
MAINTAINER Socrata <sysadmin@socrata.com>

# Default to basic no_proxy list for things that respect it such as set_ark_*
ENV no_proxy localhost,127.0.0.1,169.254.169.254,jenkins

# Add a user so containers can run things as non root.  Not perfect since it is shared across containers,
# but eventually uid namespacing will hopefully fix that.
RUN groupadd -r socrata && useradd -r -g socrata socrata
RUN groupadd -g 31415 metrics && usermod -a -G metrics socrata

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y dist-upgrade && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install \
    curl \
    dnsutils \
    python-jinja2 \
    ruby2.0 \
    zip && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends collectd-core && \
    apt-get clean && \
    rm --recursive --force /var/lib/apt/lists/*

# Explicitly require safe_yaml avoid "uninitialized constant Gem::SafeYAML" error due to version nightmares
RUN ruby2.0 -r yaml -r rubygems/safe_yaml -S gem2.0 install aws-sdk-resources --pre

COPY env_parse set_ark_host set_ark_hostname set_metrics_dir /bin/

# Credential management bits
COPY clortho-get /etc/my_init.d/clortho-get

# Create Data Directory
ENV METRICS_ROOT_DIR /data/metrics
CMD ["/sbin/my_init"]

# Configure collectd
RUN mkdir -p /etc/collectd/conf.d
COPY set_collectd_hostname set_local_dev_hostname /etc/my_init.d/
COPY collectd.conf /etc/collectd/collectd.conf
COPY sv/collectd-run /etc/service/collectd/run

# Set shutdown env vars to reasonable defaults (5 min)
ENV KILL_ALL_PROCESSES_TIMEOUT 300
ENV KILL_PROCESS_TIMEOUT 300

# LABEL must be last for proper base image discoverability
LABEL repository.socrata/runit=""
