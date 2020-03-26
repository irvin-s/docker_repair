FROM node:8
MAINTAINER MooYeol Prescott Lee "mooyoul@gmail.com"

# Install system programs
RUN apt-get update && apt-get install -y zip build-essential curl openjdk-8-jdk memcached jq && apt-get clean

# Install Redis
RUN cd /tmp && \
    mkdir redis-build && \
    cd redis-build && \
    wget http://download.redis.io/releases/redis-3.2.11.tar.gz && \
    tar xvfz redis-3.2.11.tar.gz && \
    cd redis-3.2.11 && \
    make && \
    make install && \
    cd ~ && \
    rm -rf /tmp/redis-build

# Install additional dependencies
# Took from https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#chrome-headless-doesnt-launch-on-unix
RUN apt-get update \
    && apt-get install -y \
      gconf-service \
      libasound2 \
      libatk1.0-0 \
      libatk-bridge2.0-0 \
      libc6 \
      libcairo2 \
      libcups2 \
      libdbus-1-3 \
      libexpat1 \
      libfontconfig1 \
      libgcc1 \
      libgconf-2-4 \
      libgdk-pixbuf2.0-0 \
      libglib2.0-0 \
      libgtk-3-0 \
      libnspr4 \
      libpango-1.0-0 \
      libpangocairo-1.0-0 \
      libstdc++6 \
      libx11-6 \
      libx11-xcb1 \
      libxcb1 \
      libxcomposite1 \
      libxcursor1 \
      libxdamage1 \
      libxext6 \
      libxfixes3 \
      libxi6 \
      libxrandr2 \
      libxrender1 \
      libxss1 \
      libxtst6 \
      ca-certificates \
      fonts-liberation \
      libappindicator1 \
      libnss3 \
      lsb-release \
      xdg-utils \
      wget \
    && apt-get clean


# Install latest chrome dev package.
# Note: this installs the necessary libs to make the bundled version of Chromium that Pupppeteer
# installs, work.
#RUN apt-get update && apt-get install -y wget --no-install-recommends \
#    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
#    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
#    && apt-get update \
#    && apt-get install -y google-chrome-unstable \
#      --no-install-recommends \
#    && rm -rf /var/lib/apt/lists/* \
#    && apt-get purge --auto-remove -y curl \
#    && rm -rf /src/*.deb

# Configure JAVA HOME
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
