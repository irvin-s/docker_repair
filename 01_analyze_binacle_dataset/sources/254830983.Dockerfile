FROM snapcraft/ubuntu-base:arm64-16.04.1
MAINTAINER Rex Tsai "http://about.me/chihchun"

ENV SNAPCRAFT_VERSION=2.17

# qemu-user-static
ADD qemu-aarch64-static /usr/bin/qemu-aarch64-static

ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i "/^# deb.*universe/ s/^# //" /etc/apt/sources.list
RUN sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list
RUN apt-get update

# snapcraft
RUN apt-get install -y snapcraft=${SNAPCRAFT_VERSION}

# Setup sudo for apt-get
RUN apt-get install -y sudo
RUN echo "ALL ALL=NOPASSWD: /usr/bin/apt-get" >> /etc/sudoers.d/apt-get \
 && chmod 0440 /etc/sudoers.d/apt-get
# sudo requires a pw entry
RUN for i in $(seq 500 1100); do echo snapper:x:$i:100:a build user:/build:/bin/bash ; done | tee -a /etc/passwd

# Clean up
RUN apt-get clean

# snapcraft need to save configs in ${HOME}/.local
ENV HOME /home
VOLUME /build
WORKDIR /build

ADD docker-entrypoint.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
