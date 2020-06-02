FROM alpine:3.4

# Alpine FFMPG from Bruno Celeste <bruno@coconut.co>

ENV FFMPEG_VERSION=3.0.8

WORKDIR /tmp/ffmpeg

RUN apk add --update --update-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ fdk-aac-dev

RUN apk add build-base curl nasm tar bzip2 \
 zlib-dev openssl-dev yasm-dev lame-dev libogg-dev x264-dev libvpx-dev libvorbis-dev\
 x265-dev freetype-dev libass-dev libwebp-dev rtmpdump-dev libtheora-dev opus-dev && \

  DIR=$(mktemp -d) && cd ${DIR} && \

  curl -s http://ffmpeg.org/releases/ffmpeg-${FFMPEG_VERSION}.tar.gz | tar zxvf - -C . && \
  cd ffmpeg-${FFMPEG_VERSION} && \
  ./configure \
  --enable-version3 --enable-gpl --enable-nonfree --enable-small --enable-libmp3lame --enable-libx264 --enable-libx265 \
  --enable-libvpx --enable-libtheora --enable-libvorbis --enable-libopus --enable-libass --enable-libwebp --enable-librtmp \
  --enable-postproc --enable-avresample --enable-libfreetype --enable-openssl --enable-libfdk-aac --disable-debug && \
  make && \
  make install && \
  make distclean && \

  rm -rf ${DIR} && \
  apk del build-base curl tar bzip2 x264 openssl nasm && rm -rf /var/cache/apk/*
  
RUN apk update && apk add ca-certificates wget

# where external videos will be mounted
RUN mkdir /storage 

RUN mkdir /lib64 && ln -s /lib/libc.musl-x86_64.so.1 /lib64/ld-linux-x86-64.so.2
  
RUN wget https://github.com/mobileblobs/chrometizer/raw/master/dist/chrometizer && \
  chmod +x chrometizer && mv chrometizer /usr/local/bin

CMD chrometizer
