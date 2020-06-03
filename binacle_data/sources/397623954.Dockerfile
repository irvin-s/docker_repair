FROM fedora:28

RUN dnf -y install \
    cairo-devel \
    cairo-gobject-devel \
    e2fsprogs-devel \
    gcc \
    gcc-c++ \
    gdk-pixbuf2-devel \
    gdk-pixbuf2-modules \
    gettext \
    git \
    gjs \
    glib-networking \
    glib2-devel \
    glibc-devel \
    glibc-headers \
    gobject-introspection-devel \
    gtk-doc \
    intltool \
    json-glib-devel \
    libarchive-devel \
    libsoup-devel \
    libxml2-devel \
    mozjs52 \
    ostree \
 && dnf clean all

ARG HOST_USER_ID=5555
ENV HOST_USER_ID ${HOST_USER_ID}
RUN useradd -u $HOST_USER_ID -ms /bin/bash user

USER user
WORKDIR /home/user

ENV LANG C.UTF-8
