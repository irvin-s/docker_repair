FROM fedora:28

RUN dnf -y install \
    adwaita-icon-theme \
    atk-devel \
    at-spi2-atk-devel \
    cairo-devel \
    cairo-gobject-devel \
    ccache \
    cogl-devel \
    desktop-file-utils \
    elfutils-libelf-devel \
    fribidi-devel \
    gcc \
    gcc-c++ \
    gdk-pixbuf2-devel \
    gdk-pixbuf2-modules \
    gettext \
    git \
    glib2-devel \
    glibc-devel \
    glibc-headers \
    gobject-introspection-devel \
    gtk-doc \
    gtk3-devel \
    itstool \
    json-glib-devel \
    libffi-devel \
    libgudev-devel \
    libinput-devel \
    librsvg2 \
    libXcomposite-devel \
    libXcursor-devel \
    libXcursor-devel \
    libXdamage-devel \
    libXfixes-devel \
    libXi-devel \
    libXinerama-devel \
    libxkbcommon-devel \
    libXrandr-devel \
    libXrender-devel \
    libxslt \
    mesa-dri-drivers \
    mesa-libEGL-devel \
    mesa-libwayland-egl-devel \
    ninja-build \
    pango-devel \
    pcre-devel \
    python3 \
    python3-pip \
    python3-wheel \
    redhat-rpm-config \
    systemd-devel \
    wayland-devel \
    wayland-protocols-devel \
    which \
    xorg-x11-server-Xvfb \
 && dnf clean all

RUN pip3 install meson

ARG HOST_USER_ID=5555
ENV HOST_USER_ID ${HOST_USER_ID}
RUN useradd -u $HOST_USER_ID -ms /bin/bash user

USER user
WORKDIR /home/user

ENV LANG C.UTF-8
