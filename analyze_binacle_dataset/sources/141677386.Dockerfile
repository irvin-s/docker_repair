FROM ubuntu:bionic-20180526 AS builder

ENV FFMPEG_VERSION=4.0.2 \
    X264_VERSION=snapshot-20180720-2245-stable \
    FFMPEG_BUILD_ASSETS_DIR=/var/lib/docker-ffmpeg \
    FFMPEG_BUILD_ROOT_DIR=/var/lib/docker-ffmpeg/rootfs

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
      wget ca-certificates make gcc g++ pkg-config

COPY assets/build/ ${FFMPEG_BUILD_ASSETS_DIR}/

RUN chmod +x ${FFMPEG_BUILD_ASSETS_DIR}/install.sh

RUN ${FFMPEG_BUILD_ASSETS_DIR}/install.sh

FROM ubuntu:bionic-20180526

LABEL maintainer="sameer@damagehead.com"

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
      libssl1.0 \
 && rm -rf /var/lib/apt/lists/*

COPY --from=builder /var/lib/docker-ffmpeg/rootfs /

ENTRYPOINT ["/usr/bin/ffmpeg"]

CMD ["--help"]



# RUN apt-get update \
#  && DEBIAN_FRONTEND=noninteractive apt-get install -y bzip2 libgnutlsxx27 libogg0 libjpeg8 libpng12-0 \
#       libvpx1 libtheora0 libxvidcore4 libmpeg2-4 \
#       libvorbis0a libfaad2 libmp3lame0 libmpg123-0 libmad0 libopus0 libvo-aacenc0 \
#  && rm -rf /var/lib/apt/lists/*
