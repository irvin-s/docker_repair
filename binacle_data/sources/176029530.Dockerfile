FROM python:2.7

RUN usermod -d /home www-data && chown www-data:www-data /home

# Install dependancies
RUN apt-get update \
    && apt-get install -y \
        git \
        libev4 \
        libev-dev \
        libevent-dev \
        libxml2-dev \
        libxslt1-dev \
        zlib1g-dev \
        # cryptography
        build-essential \
        libssl-dev \
        libffi-dev \
        python-dev \
    && apt-get clean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# grab gosu for easy step-down from root
ENV GOSU_VERSION 1.4
RUN apt-get update \
    && apt-get install -y \
        curl \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
    && curl -o /usr/local/bin/gosu -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
  	&& curl -o /usr/local/bin/gosu.asc -SL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
  	&& gpg --verify /usr/local/bin/gosu.asc \
  	&& rm /usr/local/bin/gosu.asc \
  	&& chmod +x /usr/local/bin/gosu \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION 0.12.4
ENV NPM_VERSION 2.10.1
RUN apt-get update \
    && apt-get install -y \
        curl \
    && gpg --keyserver pool.sks-keyservers.net --recv-keys 7937DFD2AB06298B2293C3187D33FF9D0246406D 114F43EE0176B71C7BC219DD50A3051F888C628D \
    && curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  	&& curl -SLO "http://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  	&& gpg --verify SHASUMS256.txt.asc \
  	&& grep " node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
  	&& tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  	&& rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc \
  	&& npm install -g npm@"$NPM_VERSION" \
  	&& npm cache clear \
    && apt-get clean \
    && apt-get autoremove -y \
        curl \
    && rm -rf /var/lib/apt/lists/*

ENV SOURCE_BRANCH master
ENV SOURCE_REPO https://github.com/prerender/prerender
ENV SOURCE_COMMIT 7bfe6b95e901e231cbad6a96a6e5b3d4a395fbf1

WORKDIR /code

# perform an initial build to cache long running compilations
RUN git clone -b $SOURCE_BRANCH $SOURCE_REPO . \
    && git checkout $SOURCE_COMMIT . \
    && chown -R www-data:www-data /code

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN npm install
RUN npm install prerender-redis-cache --save

EXPOSE 3000

CMD [ "gosu", "www-data", "node", "server.js" ]
