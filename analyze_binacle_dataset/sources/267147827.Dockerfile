FROM node:8.9
MAINTAINER Ian Sinnott "ian989@gmail.com"
RUN apt-get update -y
RUN apt-get install -y software-properties-common

# Add Yarn source
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Add imagemagic source
RUN add-apt-repository -y ppa:dhor/myway

# Install imagemagic and related tools for PNG generation (required to generate
# rxjs docs). Also install yarn for speedier node_modules installation
RUN apt-get update -y
RUN apt-get install -y imagemagick graphicsmagick ghostscript yarn
