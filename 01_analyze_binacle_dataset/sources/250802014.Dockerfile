FROM scratch
ADD ubuntu-xenial-core-cloudimg-arm64-root.tar.gz /
ADD x86_64_qemu-aarch64-static.tar.gz /usr/bin

# a few minor docker-specific tweaks
# see https://github.com/docker/docker/blob/master/contrib/mkimage/debootstrap
RUN echo '#!/bin/sh' > /usr/sbin/policy-rc.d \
 && echo 'exit 101' >> /usr/sbin/policy-rc.d \
 && chmod +x /usr/sbin/policy-rc.d \
 \
 && dpkg-divert --local --rename --add /sbin/initctl \
 && cp -a /usr/sbin/policy-rc.d /sbin/initctl \
 && sed -i 's/^exit.*/exit 0/' /sbin/initctl \
 \
 && echo 'force-unsafe-io' > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup \
 \
 && echo 'DPkg::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' > /etc/apt/apt.conf.d/docker-clean \
 && echo 'APT::Update::Post-Invoke { "rm -f /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin || true"; };' >> /etc/apt/apt.conf.d/docker-clean \
 && echo 'Dir::Cache::pkgcache ""; Dir::Cache::srcpkgcache "";' >> /etc/apt/apt.conf.d/docker-clean \
 \
 && echo 'Acquire::Languages "none";' > /etc/apt/apt.conf.d/docker-no-languages \
 \
 && echo 'Acquire::GzipIndexes "true"; Acquire::CompressionTypes::Order:: "gz";' > /etc/apt/apt.conf.d/docker-gzip-indexes

# enable the universe
RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list

# add ARTIK repository
RUN echo "deb http://repo.artik.cloud/artik/bin/pub/artik/ubuntu xenial main" > /etc/apt/sources.list.d/artik-e2e-sources.list && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 55955AEB

# install dependencies for ARTIK SDK
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    autoconf \
    automake \
    ca-certificates \
    cmake \
    gcc \
    git \
    libtool \
    m4 \
    make \
    pkg-config \
    build-essential \
    cmake \
    debhelper \
    libwebsockets-dev \
    libglib2.0-dev \
    libgstreamer1.0-dev \
    libdbus-1-dev \
    libcurl4-openssl-dev \
    libssl-dev \
    libmosquitto-dev \
    libcunit1-dev \
    libzigbee-dev \
    wakaama-client-dev \
    libcoap-dev \
 && rm -rf /var/lib/apt/lists/*

# overwrite this with 'CMD []' in a dependent Dockerfile
CMD ["/bin/bash"]

