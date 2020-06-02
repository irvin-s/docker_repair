FROM snapcraft/xenial-amd64:2.20
MAINTAINER Rex Tsai "http://about.me/chihchun"

ENV UBUNTUIMAGE_VERSION=0.10+real1
RUN apt-get install -y --no-install-recommends \
        devscripts \
        equivs \
        git


WORKDIR /tmp
RUN git clone --depth 1 --branch ${UBUNTUIMAGE_VERSION} https://github.com/CanonicalLtd/ubuntu-image \
 && cd ubuntu-image \
 && mk-build-deps debian/control -i --tool 'apt-get -y --no-install-recommends' \
 && dpkg-buildpackage -us -uc \
 && apt-get install -y ../*.deb \
 && mkdir -p /snap/bin \
 && ln -s /usr/bin/ubuntu-image /snap/bin/ubuntu-image

RUN echo "ALL ALL=NOPASSWD: /snap/bin/ubuntu-image" >> /etc/sudoers.d/ubuntu-image \
 && chmod 0440 /etc/sudoers.d/ubuntu-image

# Install toolchins
RUN apt-get install -y build-essential u-boot-tools lzop debootstrap \
    gcc-4.8 \
    gcc-arm-linux-gnueabihf gcc-4.8-arm-linux-gnueabihf \
    device-tree-compiler

# change the default gcc to 4.8, since old kernel need old gcc.
RUN update-alternatives --install /usr/bin/gcc gcc  /usr/bin/gcc-5 50 \
 && update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-5 50
RUN update-alternatives --install /usr/bin/gcc gcc  /usr/bin/gcc-4.8 100 \
 && update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-4.8 100

# multiarch.
RUN dpkg --add-architecture i386 && apt-get update && apt-get install -y libc6:i386

RUN apt-get remove --purge -y devscripts equivs
RUN apt-get autoremove -y
RUN apt-get clean -y
RUN rm -rf /tmp/* /var/tmp/*

WORKDIR /build
