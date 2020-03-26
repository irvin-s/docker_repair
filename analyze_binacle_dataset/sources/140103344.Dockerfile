FROM node:8.12.0

MAINTAINER David You <frog@falinux.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update

RUN apt-get install -y locales
RUN dpkg-reconfigure locales 
RUN locale-gen C.UTF-8 
RUN /usr/sbin/update-locale LANG=C.UTF-8
  
# Install needed default locale for Makefly
RUN echo 'ko_KR.UTF-8 UTF-8' | tee --append /etc/locale.gen
RUN locale-gen

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG ko_KR.UTF-8
ENV LANGUAGE ko_KR.UTF-8

RUN apt-get update && apt-get install -y apt-utils

RUN apt-get update && \
    apt-get install -y \
    libgtk2.0-0 \
    libnotify-dev \
    libgconf-2-4 \
    libnss3 \
    libxss1 \
    libasound2 \
    xvfb

RUN apt-get update && apt-get install -y fonts-nanum

RUN echo "force new chrome here"

# install Chromebrowser
RUN \
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list && \
apt-get update && \
apt-get install -y dbus-x11 google-chrome-stable && \
rm -rf /var/lib/apt/lists/*

# "fake" dbus address to prevent errors
# https://github.com/SeleniumHQ/docker-selenium/issues/87
ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

# Add zip utility - it comes in very handy
RUN apt-get update && apt-get install -y zip

# RUN npm install -g npm@6.4.1
RUN yarn global add @vue/cli

# versions of local tools
RUN node -v
RUN npm -v
RUN yarn -v
RUN vue --version
RUN google-chrome --version
RUN zip --version
RUN git --version

# good colors for most applications
ENV TERM xterm
# avoid million NPM install messages
ENV npm_config_loglevel warn
# allow installing when the main user is root
ENV npm_config_unsafe_perm true

WORKDIR /apps
CMD bash
