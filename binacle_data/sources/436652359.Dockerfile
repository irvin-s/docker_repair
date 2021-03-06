# Container to build Linux version of Flow QT Byte Runner
# Requires docker >=17.05 for multistage builds
# Not trying to make self contained app here because dependancies are a mess
# Just attach whole area9/qt wherever it will be used and pray for the best.
FROM area9/qt:%QT_VERSION% as qt

# Same will work with bionic but kept on xenial until area9/android upgrade
FROM ubuntu:xenial

ARG qt_version=5.9.2
ARG qt_path=/opt/Qt${qt_version}
ARG qt_full_path=${qt_path}/${qt_version}/gcc_64

ENV QT_VERSION=${qt_version}
ENV QT_FULL_PATH=${qt_full_path}

COPY --from=qt ${qt_path} ${qt_path}

ENV PATH="${PATH}:${qt_full_path}/bin"
RUN echo "${qt_full_path}/lib" > /etc/ld.so.conf.d/qt.conf \
  && ldconfig

RUN apt-get update \
  && apt-get install -y \
    build-essential \
    libasound2 \
    libdbus-1-3 \
    libegl1-mesa \
    libfontconfig1 \
    libfreetype6 \
    libglib2.0-0 \
    libglu1-mesa-dev \
    libjpeg8-dev \
    libnspr4 \
    libnss3 \
    libpulse0 \
    libpulse-dev \
    libpulse-mainloop-glib0 \
    libxcomposite1 \
    libxcursor1 \
    libxi6 \
    libxml2 \
    libxrandr2 \
    libxrender1 \
    libxslt1.1 \
    libxss1 \
    libxtst6 \
    zlib1g-dev

# special treatment for libpng12 since it's missing in Ubuntu 18 repos
# Not bundled with previous command because I care more about reusing cache
# than about resulting image size. This image is only used for building things
# anyway.
ADD http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-dev_1.2.54-1ubuntu1.1_amd64.deb libpng12-dev.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb libpng12.deb
RUN dpkg -i libpng12.deb libpng12-dev.deb


# This is for convenience so that resulting files will belong to regular user
# instead of root. Will be useless on multi-user systems.
ARG uid=1000
ARG gid=1000
RUN addgroup --gid=${gid} flow \
  && useradd --uid=${uid} \
             --gid=${gid} \
             --no-create-home \
             --home=/flow \
             --shell=/bin/bash \
             flow

# build_image.sh takes care of preparing qbr for us
COPY qbr /flow
RUN chown -R flow:flow /flow

USER flow
ENV FLOW="/flow"
WORKDIR /flow/platforms/qt

CMD ["./build.sh"]

