FROM ubuntu:trusty
MAINTAINER Christian Lück <christian@lueck.tv>

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apt-cacher \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# allow access from everywhere
RUN echo "allowed_hosts = *" >> /etc/apt-cacher/apt-cacher.conf

# limit disk usage
# TODO: does not work as of now. Seems to interpret as 0 bytes maximum
# RUN echo "disk_usage_limit = 10GB" > /etc/apt-cacher/conf.d/disk.conf

# enable multi-distro support (debian and ubuntu alike)
RUN echo "distinct_namespaces = 1" >> /etc/apt-cacher/apt-cacher.conf

# extend ubuntu release names (and keep adding future versions...)
ENV UBUNTU_RELEASE_NAMES dapper, edgy, feisty, gutsy, hardy, intrepid, jaunty, karmic, lucid, maverick, natty, oneiric, precise, quantal, trusty, utopic, vivid

ADD run.sh /
ENTRYPOINT ["/run.sh"]
CMD []
EXPOSE 3142
VOLUME ["/var/cache/apt-cacher"]
