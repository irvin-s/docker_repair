FROM debian:buster

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive \
    apt-get install --yes --no-install-recommends \
    clang \
    gcc \
    gettext \
    libglib2.0-dev \
    libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev \
    libgtk-3-dev \
    libkeybinder-3.0-dev \
    libsoup2.4-dev \
    locales \
    meson \
    pkg-config \
 && rm -rf /var/lib/apt/lists/*

RUN useradd \
    --create-home \
    --shell /bin/bash \
    --uid 4321 \
    builder

USER builder
WORKDIR /home/builder

ENV LANG C.UTF-8
