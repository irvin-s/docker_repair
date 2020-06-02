##
## Build with:
##   docker build -t xeffyr/termux-musl-env-builder .
##
## Push to docker hub with:
##   docker push xeffyr/termux-musl-env-builder
##

FROM ubuntu:bionic

# Make sure that everything is up-to-date.
RUN apt update && env DEBIAN_FRONTEND=noninteractive apt upgrade -y

# Install basic build tools (binutils, gcc, make, etc...).
RUN env DEBIAN_FRONTEND=noninteractive apt install -y build-essential

# Install additional essential packages.
RUN env DEBIAN_FRONTEND=noninteractive \
    apt install -y asciidoc asciidoctor autoconf automake bison curl \
    ed flex g++-multilib gawk gettext git gperf help2man intltool \
    libexpat1-dev libglib2.0-dev libjpeg-dev libncurses5-dev libncursesw5-dev \
    libssl-dev libtool-bin lzip m4 openjdk-8-jdk-headless pkg-config \
    python-pip python3.7 python3-docutils python3-pip python3-setuptools \
    python3-sphinx ruby scons texinfo unzip xmlto zip zlib1g-dev

# This required by some X11-based packages.
RUN env DEBIAN_FRONTEND=noninteractive \
    apt install -y gnome-common gtk-3-examples gtk-doc-tools \
    libgdk-pixbuf2.0-dev libgtk-3-bin xfonts-utils

# These devpackages required for building cross-compiler.
# Note: pax-utils provides "scanelf" which is required by build script.
RUN env DEBIAN_FRONTEND=noninteractive \
    apt install -y libgmp-dev libisl-dev libmpc-dev libmpfr-dev pax-utils

# Install developer tools.
RUN env DEBIAN_FRONTEND=noninteractive \
    apt install -y nano silversearcher-ag patchutils

# Create user and add it to sudoers.
RUN env DEBIAN_FRONTEND=noninteractive \
    apt install -y sudo && \
    useradd -U -m builder && \
    echo "builder ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/builder

# Create necessary directories.
RUN mkdir /data && chown builder:builder /data && \
    mkdir -p /opt/termux && chown builder:builder /opt/termux

# Copy our scripts to the image temporarily.
RUN mkdir /home/builder/termux-musl
COPY ./scripts /home/builder/termux-musl/scripts
RUN chown -Rh builder:builder /home/builder/termux-musl

# Setup toolchains.
RUN curl --fail --retry 3 -L -o toolchain.tar.bz2 https://termux-musl.ml/toolchains/toolchain-aarch64.tar.bz2 && \
    tar xf toolchain.tar.bz2 -C /opt/termux && rm -f toolchain.tar.bz2 && \
    curl --fail --retry 3 -L -o toolchain.tar.bz2 https://termux-musl.ml/toolchains/toolchain-arm.tar.bz2 && \
    tar xf toolchain.tar.bz2 -C /opt/termux && rm -f toolchain.tar.bz2 && \
    curl --fail --retry 3 -L -o toolchain.tar.bz2 https://termux-musl.ml/toolchains/toolchain-i686.tar.bz2 && \
    tar xf toolchain.tar.bz2 -C /opt/termux && rm -f toolchain.tar.bz2 && \
    curl --fail --retry 3 -L -o toolchain.tar.bz2 https://termux-musl.ml/toolchains/toolchain-x86_64.tar.bz2 && \
    tar xf toolchain.tar.bz2 -C /opt/termux && rm -f toolchain.tar.bz2 && \
    chown -Rh builder:builder /opt/termux
## UNCOMMENT if you want to recompile toolchains.
#RUN chown builder:builder -Rh /home/builder/termux-musl && \
#    su - builder -c "env TERMUX_ARCH=aarch64 /home/builder/termux-musl/scripts/cross-toolchain/build-toolchain.sh" && \
#    su - builder -c "env TERMUX_ARCH=arm /home/builder/termux-musl/scripts/cross-toolchain/build-toolchain.sh" && \
#    su - builder -c "env TERMUX_ARCH=i686 /home/builder/termux-musl/scripts/cross-toolchain/build-toolchain.sh" && \
#    su - builder -c "env TERMUX_ARCH=x86_64 /home/builder/termux-musl/scripts/cross-toolchain/build-toolchain.sh" && \
#    rm -rf /home/builder/.toolchain_build

# Setup Android SDK.
RUN curl --fail --retry 3 -L -o sdk.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip && \
    unzip -q sdk.zip -d /opt/termux/android-sdk && rm -f sdk.zip && \
    chown -Rh builder:builder /opt/termux
RUN su - builder -c "/home/builder/termux-musl/scripts/setup-sdk.sh"

# Install fake ldconfig script.
COPY ./scripts/fake-ldconfig.sh /usr/local/bin/ldconfig
RUN chmod 755 /usr/local/bin/ldconfig

# Cleanup.
RUN apt-get clean && \
    rm -rf /home/builder/termux-musl && \
    rm -rf /var/lib/apt/lists/*

# Set work directory to our repository.
WORKDIR /home/builder/termux-musl
