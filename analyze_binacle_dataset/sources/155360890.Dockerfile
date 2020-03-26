FROM ubuntu:trusty
MAINTAINER  Jessica Frazelle <github.com/jessfraz>

# install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    curl \
    python-software-properties \
    software-properties-common \
    sqlite3 \
    unzip \
    --no-install-recommends

# install node
RUN curl -sL https://deb.nodesource.com/setup | bash -
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    nodejs \
    --no-install-recommends

RUN npm install -g forever

# Download Ghost v0.5.0
RUN curl -L https://ghost.org/zip/ghost-0.5.0.zip -o /tmp/ghost.zip

# Unzip Ghost zip to /src
RUN unzip -uo /tmp/ghost.zip -d /src

# Add custom config js to /data/ghost
COPY ./config.js /src/config.js

# Install Ghost with NPM
RUN cd /src; npm install --production

WORKDIR /src

EXPOSE 2368

CMD forever start --debug --verbose --minUptime 5000 --sourceDir /src --spinSleepTime 2000 -a -l /src/log index.js && tail -f /src/log
