FROM node:8.11.2

EXPOSE 3000

CMD ["node", "/app/main.js"]

ENV GOSU_VERSION=1.10

RUN \
    # Gosu installation
    GOSU_ARCHITECTURE="$(dpkg --print-architecture | awk -F- '{ print $NF }')" && \
    wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${GOSU_ARCHITECTURE}" && \
    wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${GOSU_ARCHITECTURE}.asc" && \
    export GNUPGHOME="$(mktemp -d)" && \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && \
    gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu && \
    rm -R "$GNUPGHOME" /usr/local/bin/gosu.asc && \
    chmod +x /usr/local/bin/gosu

RUN apt-get update && \
    apt-get install -y imagemagick unicode-data --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get autoclean && \
    apt-get clean

COPY imagemagick-policy.xml /etc/ImageMagick-6/policy.xml

COPY ./app/.meteor/release /meteor-release

ENV BUILD_DEPS="bzip2 build-essential python git ca-certificates"

RUN \
    # Add non-root user meteor
    useradd --user-group --system --home-dir /home/meteor meteor && \
    \
    # OS dependencies
    apt-get update -y && apt-get install -y --no-install-recommends ${BUILD_DEPS} && \
    \
    # Install Node dependencies
    npm install -g node-gyp && \
    npm install -g fibers && \
    \
    # Change user to meteor and install meteor
    mkdir -p /home/meteor/app && \
    cd /home/meteor/ && \
    chown meteor:meteor --recursive /home/meteor && \
    curl https://install.meteor.com -o ./install_meteor.sh && \
    echo "Starting meteor installation...   \n" && \
    chown meteor:meteor ./install_meteor.sh && \
    gosu meteor:meteor sh ./install_meteor.sh

COPY ./app /tmp/app

ENV TOOL_NODE_FLAGS="--max-old-space-size=4096"

RUN \
    # Build app
    cd /home/meteor/app && \
    cp -R /tmp/app /home/meteor && \
    chown meteor:meteor --recursive . && \
    gosu meteor /home/meteor/.meteor/meteor npm install && \
    gosu meteor /home/meteor/.meteor/meteor build --server-only --directory /home/meteor/app_build && \
    cd /home/meteor/app_build/bundle/programs/server/ && \
    gosu meteor npm install && \
    mv /home/meteor/app_build/bundle /app && \
    cd /app && \
    \
    # Cleanup
    apt-get remove --purge -y ${BUILD_DEPS} && \
    apt-get autoremove -y && \
    rm -R /var/lib/apt/lists/* && \
    rm -R /home/meteor/.meteor && \
    rm -R /home/meteor/app && \
    rm -R /home/meteor/app_build && \
    rm -R /tmp/* && \
    rm /home/meteor/install_meteor.sh

VOLUME /tmp /var/tmp

USER meteor
