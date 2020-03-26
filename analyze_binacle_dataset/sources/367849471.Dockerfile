FROM debian

RUN apt-get update -q && apt-get install -y \
    libgmp-dev \
    zlib1g-dev \
    curl \
    build-essential \
    yasm

ENV FFMPEG_ARCHIVE_URL  http://www.ffmpeg.org/releases/ffmpeg-3.1.tar.gz
ENV FFMPEG_BUILD_DIR    /ffmpeg-build
ENV FFMPEG_DIST_DIR     /ffmpeg
RUN mkdir ${FFMPEG_BUILD_DIR} &&\
    curl -L ${FFMPEG_ARCHIVE_URL} | tar xz -C ${FFMPEG_BUILD_DIR} --strip-components 1 &&\
    cd ${FFMPEG_BUILD_DIR} &&\
    ./configure --prefix=${FFMPEG_DIST_DIR} &&\
    make -j$(nproc) install > build.log &&\
    rm -rf ${FFMPEG_BUILD_DIR}

ENV FFMPEG_PATH         ${FFMPEG_DIST_DIR}/bin/ffmpeg

ENTRYPOINT ["/streamer/twitch-cast-streamer"]
