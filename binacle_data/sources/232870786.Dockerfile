FROM fedora:28

RUN dnf -y install \
    clang \
    findutils \
    gcc \
    gettext-devel \
    glib2-devel \
    gstreamer1-devel \
    gstreamer1-plugins-base-devel \
    gtk3-devel \
    keybinder3-devel \
    libsoup-devel \
    meson \
    pkgconfig \
    tar \
    xz \
 && dnf clean all

RUN useradd \
    --create-home \
    --shell /bin/bash \
    --uid 4321 \
    builder

USER builder
WORKDIR /home/builder

ENV LANG C.UTF-8
