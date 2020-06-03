# webgefrickel/docker-frontend-tools
# VERSION 1.0.0

# using debian results in a smaller image-size :-)
FROM debian:jessie

# Twitter: @webgefrickel
MAINTAINER Steffen Rademacker <kontakt@webgefrickel.de>

# set the wanted versions for dev-tools here
# other tools will be installed too, but the versions for those
# is not really relevant - most are capsuled in gulp/grunt-*
# node-modules anyways - the others are just for convenience
ENV GULP_VERSION 3.8.11
ENV GRUNT_VERSION 0.1.13
ENV SASS_VERSION 3.4.12
ENV COMPASS_VERSION 1.0.3

# global dependencies / build-essentials and cli-tools
RUN \
  apt-get update && \
  apt-get install -y --force-yes build-essential git curl && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# install most current node and global node packages
RUN \
  curl -sL https://deb.nodesource.com/setup | bash - && \
  apt-get install -y --force-yes nodejs && \
  curl -sL https://npmjs.org/install.sh | sh && \
  npm install -g gulp@$GULP_VERSION && \
  npm install -g grunt-cli@$GRUNT_VERSION && \
  npm install -g bower && \
  npm install -g browserify && \
  npm install -g eslint && \
  npm install -g jsonlint && \
  npm install -g npm-check-updates && \
  npm install -g stylestats

# Install ruby (2.1 in jessie) and frontend gems (without docs)
# ruby-dev is needed for building native compass extensions
# no bundler needed, thats what this dockerfile is for after all
RUN \
  apt-get install -y --force-yes ruby ruby-dev && \
  gem install sass --no-document --version $SASS_VERSION && \
  gem install compass --no-document --version $COMPASS_VERSION && \
  gem install scss-lint --no-document

# create the working dir
RUN mkdir /code

# set the working dir
WORKDIR /code
