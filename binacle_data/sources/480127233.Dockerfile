FROM fedora:28

RUN dnf clean all
RUN dnf install -y dnf-command\(builddep\) rpmdevtools

RUN dnf clean all
RUN dnf upgrade -y && \
    dnf install -y \
        git \
        rpm-build \
        tar \
        make \
        autoconf \
        automake \
        cmake \
        speexdsp-devel \
        pulseaudio-libs-devel \
        libcanberra-devel \
        libtool \
        dbus-devel \
        expat-devel \
        pcre-devel \
        yaml-cpp-devel \
        boost-devel \
        dbus-c++-devel \
        dbus-devel \
        libXext-devel \
        libXfixes-devel \
        yasm \
        nasm \
        speex-devel \
        gsm-devel \
        chrpath \
        check \
        astyle \
        uuid-c++-devel \
        libupnp-devel \
        gettext-devel \
        gcc-c++ \
        which \
        alsa-lib-devel \
        systemd-devel \
        libuuid-devel \
        uuid-devel \
        gnutls-devel \
        nettle-devel \
        opus-devel \
        patch \
        jsoncpp-devel \
        libnatpmp-devel \
        webkitgtk4-devel \
        cryptopp-devel \
        libva-devel \
        libvdpau-devel \
        msgpack-devel \
        NetworkManager-libnm-devel \
        openssl-devel \
        openssl-static \
        sqlite-devel \
        libsndfile-devel

ADD scripts/build-package-fedora.sh /opt/build-package-fedora.sh

CMD /opt/build-package-fedora.sh
