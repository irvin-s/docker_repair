FROM ubuntu:xenial
MAINTAINER Yuji ODA
ENV MINEOS_VERSION 1.1.7

# Installing Dependencies
RUN apt-get update; \
    apt-get -y install git rdiff-backup screen build-essential openjdk-8-jre-headless uuid pwgen curl rsync

# Installing node 4.x
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash -; \
    apt-get -y install nodejs

# Installing MineOS scripts
RUN mkdir -p /usr/games/minecraft /var/games/minecraft; \
    curl -L https://github.com/hexparrot/mineos-node/archive/v${MINEOS_VERSION}.tar.gz | tar xz -C /usr/games/minecraft --strip=1; \
    cd /usr/games/minecraft; \
    npm install; \
    chmod +x service.js mineos_console.js generate-sslcert.sh webui.js; \
    ln -s /usr/games/minecraft/mineos_console.js /usr/local/bin/mineos

# Customize server settings
ADD mineos.conf /etc/mineos.conf

# Add start script
ADD start.sh /usr/games/minecraft/start.sh
RUN chmod +x /usr/games/minecraft/start.sh

# Add minecraft user and change owner files.
RUN useradd -M -s /bin/bash -d /usr/games/minecraft minecraft

# Cleaning
RUN apt-get -y remove build-essential; \
    apt -y autoremove; \
    apt-get clean

VOLUME /var/games/minecraft
WORKDIR /usr/games/minecraft
EXPOSE 8443 25565 25566 25567 25568 25569 25570

CMD ["./start.sh"]
