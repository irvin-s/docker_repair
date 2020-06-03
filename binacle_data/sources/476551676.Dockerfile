FROM node:4.2

# Updating ubuntu packages
RUN apt-get update

# Installing the packages needed to run Nightmare
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

# ENV DEBUG="nightmare"

# Add current directory to /app
ADD . /app

# Set current working directory as /app
WORKDIR /app

# Install npm packages
RUN npm install

EXPOSE 8889

# Default command. Assumes our file is app.js and our screen size is 1024x768
CMD xvfb-run --server-args="-screen 0 1024x768x24" node app.js

# Build: docker build -t nightmarejs-webservice .
# Usage: docker run -p 8889:8889 -d nightmarejs-webservice
