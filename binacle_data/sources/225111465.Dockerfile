FROM alpine:3.3
MAINTAINER Stephane Jourdan <fasten@fastmail.fm>
ENV REFRESHED_AT 2016-02-26
ENV FFMPEG_VERSION 3.0

WORKDIR /tmp

RUN wget -q http://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz \
  && tar xJf /tmp/ffmpeg-release-64bit-static.tar.xz -C /tmp \
  && mv /tmp/ffmpeg-3.0-64bit-static/ffserver /usr/local/bin/ \
  && rm -rf /tmp/ffmpeg*

CMD ["--help"]
ENTRYPOINT ["ffserver"]
