# subsonic docker image
# Running:
# docker run -d --name subsonic \
#   -p 4040:4040 \
#   -v /mnt/subsonic:/opt/app/state \
#   -v /mnt/music:/mnt/music
#   danisla/subsonic 1000

FROM java:8-jre

MAINTAINER dan.isla@gmail.com

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
  apt-utils xz-utils sudo locales

ENV LANGUAGE en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
RUN sed -i 's/^# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
  locale-gen && dpkg-reconfigure locales && update-locale LANG=${LANG} LC_ALL=${LANG} LANGUAGE=${LANG}

EXPOSE 4040
VOLUME /mnt/music
VOLUME /opt/app/state

ARG SUBSONIC_VERSION

RUN wget "https://s3-eu-west-1.amazonaws.com/subsonic-public/download/subsonic-${SUBSONIC_VERSION}.deb" -O /tmp/subsonic.deb && \
  dpkg -i /tmp/subsonic.deb && \
  rm -rf /tmp/subsonic.deb

RUN wget http://johnvansickle.com/ffmpeg/releases/ffmpeg-release-64bit-static.tar.xz -O /tmp/ffmpeg-release-64bit-static.tar.xz && \
  mkdir -p /opt/ffmpeg && \
  tar xf /tmp/ffmpeg-release-64bit-static.tar.xz -C /opt/ffmpeg --strip-components=1

WORKDIR /opt/app
ENV SUBSONIC_CONTEXT_PATH /
ENV SUBSONIC_MAX_MEMORY 512

RUN mkdir -p /opt/app

ADD startup.sh /opt/app/
RUN chmod +x /opt/app/startup.sh

ENTRYPOINT /opt/app/startup.sh 1000
