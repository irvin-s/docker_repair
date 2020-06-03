FROM ubuntu:16.04
LABEL maintainer BoomTown CNS Team <consumerteam@boomtownroi.com>

##
## ROOTFS
##

# root filesystem
COPY rootfs /

# create *min files for apt* and dpkg* in order to avoid issues with locales
# and interactive interfaces
RUN ls /usr/bin/apt* /usr/bin/dpkg* |                                    \
    while read line; do                                                  \
      min=$line-min;                                                     \
      printf '#!/bin/sh\n/usr/bin/apt-dpkg-wrapper '$line' $@\n' > $min; \
      chmod +x $min;                                                     \
    done

##
## PREPARE
##

# temporarily disable dpkg fsync to make building faster.
RUN if [ ! -e /etc/dpkg/dpkg.cfg.d/docker-apt-speedup ]; then         \
	  echo force-unsafe-io > /etc/dpkg/dpkg.cfg.d/docker-apt-speedup; \
    fi

# prevent initramfs updates from trying to run grub and lilo.
# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=594189
ENV INITRD no

# enable Ubuntu Universe and Multiverse.
RUN sed -i 's/^#\s*\(deb.*universe\)$/\1/g' /etc/apt/sources.list   && \
    sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list && \
    apt-get-min update

# fix some issues with APT packages.
# see https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert-min --local --rename --add /sbin/initctl && \
    ln -sf /bin/true /sbin/initctl

# replace the 'ischroot' tool to make it always return true.
# prevent initscripts updates from breaking /dev/shm.
# https://journal.paul.querna.org/articles/2013/10/15/docker-ubuntu-on-rackspace/
# https://bugs.launchpad.net/launchpad/+bug/974584
RUN dpkg-divert-min --local --rename --add /usr/bin/ischroot && \
    ln -sf /bin/true /usr/bin/ischroot

# install HTTPS support for APT.
RUN apt-get-install-min apt-transport-https ca-certificates

# install add-apt-repository
RUN apt-get-install-min software-properties-common

# upgrade all packages.
RUN apt-get-min dist-upgrade -y --no-install-recommends

# fix locale.
ENV LANG en_US.UTF-8
ENV LC_CTYPE en_US.UTF-8
RUN apt-get-install-min language-pack-en        && \
    locale-gen en_US                            && \
    update-locale LANG=$LANG LC_CTYPE=$LC_CTYPE

# s6 overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.15.0.0/s6-overlay-amd64.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xvfz /tmp/s6-overlay.tar.gz -C /

##
## INIT
##

ENTRYPOINT [ "/init" ]
