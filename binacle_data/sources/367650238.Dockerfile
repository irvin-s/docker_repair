FROM mitchty/alpine-ghc:8.0.2

RUN apk update \
    && apk add \
      make \
      gcc \
      musl-dev \
      curl-dev \
      freetds-dev \
      imagemagick-dev \
      libevent-dev \
      libffi-dev \
      libxml2-dev \
      ncurses-dev \
      libressl-dev \
      postgresql-dev \
      readline-dev \
      sqlite-dev \
      unixodbc-dev \
      yaml-dev \
      zlib-dev \
      ncurses-dev \
      ncurses-libs \
      ncurses \
      ncurses5-widec-libs \
      ncurses-terminfo-base \
      ncurses-terminfo \
      git \
    && adduser -D -u1000 alpine \
    && mkdir /project \
    && chown alpine.alpine /project

USER alpine

WORKDIR /project

CMD /usr/bin/stack
