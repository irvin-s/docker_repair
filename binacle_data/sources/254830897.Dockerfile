FROM snapcraft/ubuntu-base:amd64-16.04.1
MAINTAINER Rex Tsai "http://about.me/chihchun"

ENV SNAPCRAFT_VERSION=2.17

ENV DEBIAN_FRONTEND=noninteractive
RUN sed -i "/^# deb.*universe/ s/^# //" /etc/apt/sources.list
RUN sed -i "/^# deb.*multiverse/ s/^# //" /etc/apt/sources.list
RUN apt-get update

# build and install snapcraft
WORKDIR /tmp
RUN apt-get install -y --no-install-recommends \
        devscripts \
        equivs \
        git \
	ca-certificates \
	curl

RUN git clone --depth 1 --branch ${SNAPCRAFT_VERSION} https://github.com/snapcore/snapcraft \
 && cd snapcraft \
 && mk-build-deps debian/control -i --tool 'apt-get -y --no-install-recommends' \
 && dpkg-buildpackage -us -uc \
 && apt-get install -y ../*.deb \
 && apt-get remove --purge -y devscripts equivs git python3-fixtures python3-responses python3-setuptools python3-testscenarios python3-testtools \
 && apt-get autoremove -y \
 && apt-get clean -y
RUN rm -rf /tmp/* /var/tmp/*

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
