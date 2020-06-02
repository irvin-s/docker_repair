FROM node:4.2
MAINTAINER unite.flights <docker@unite.flights>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd --system nightmare && useradd --system --create-home --gid nightmare nightmare
ENV HOME "/home/nightmare"

ENV DEBUG=nightmare
ENV ARGUMENTS=()

RUN apt-get update && apt-get install -y \
  xvfb \
  x11-xkb-utils \
  xfonts-100dpi \
  xfonts-75dpi \
  xfonts-scalable \
  xfonts-cyrillic \
  x11-apps \
  clang \
  libdbus-1-dev \
  libgtk2.0-dev \
  libnotify-dev \
  libgnome-keyring-dev \
  libgconf2-dev \
  libasound2-dev \
  libcap-dev \
  libcups2-dev \
  libxtst-dev \
  libxss1 \
  libnss3-dev \
  gcc-multilib \
  g++-multilib && \
    rm -rf /var/lib/apt/lists/* && \
		find /usr/share/doc -depth -type f ! -name copyright | xargs rm || true && \
		find /usr/share/doc -empty | xargs rmdir || true && \
		rm -rf /usr/share/man/* /usr/share/groff/* /usr/share/info/* && \
		rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/*

WORKDIR ${HOME}
COPY ./package.json ./
RUN npm install

VOLUME ${HOME}

COPY docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
