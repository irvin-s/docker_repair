FROM ubuntu:18.04

RUN apt-get update --fix-missing && apt-get install -y build-essential

# Some utilities for npm
RUN apt-get install -y \
    python \
    git

# GraphicsMagick is used for image resizing
RUN apt-get install -y graphicsmagick

# nvm is used to run specific Node versions, see https://github.com/creationix/nvm
# Node has to be installed manually via "nvm install" after starting the container
RUN apt-get install -y curl
RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

# Prepare directory to mount app
WORKDIR /app

# Expose dev server and livereload
EXPOSE 9000
EXPOSE 35729
