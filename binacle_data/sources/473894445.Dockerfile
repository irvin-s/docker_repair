FROM node:4.2.6
MAINTAINER Fraser Xu <xvfeng123@gmail.com>

RUN apt-get update

# Install dependencies for running electron
RUN apt-get install -y \
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
  g++-multilib

# Include the local file to working directory
# I keep node_modules here because it's faster than install inside the container.
ADD . /app

WORKDIR /app

# Need to rebuild because modules are installed from local
RUN npm install && npm rebuild

# "xvfb-run -a [mycommand]" so xvfb uses another display if 99 is in use.
CMD Xvfb -ac -screen scrn 1280x2000x24 :9.0 & export DISPLAY=:9.0 && npm test
