FROM base/stretch

# Install Node and npm
ENV NODE_VER 8.12.0
ENV NODE_PATH /usr/local/bin/node-v${NODE_VER}/bin
RUN mkdir -p ${NODE_PATH}
RUN curl -fsSLO https://nodejs.org/download/release/v${NODE_VER}/node-v${NODE_VER}-linux-x64.tar.gz \
    && tar --strip-components=1 -xvzf node-v${NODE_VER}-linux-x64.tar.gz -C /usr/local/bin/node-v${NODE_VER} \
    && rm node-v${NODE_VER}-linux-x64.tar.gz
ENV PATH ${NODE_PATH}:$PATH

# Upgrade npm and install typescript
RUN npm install -g npm \
    && npm install -g typescript

# Install Yarn repository and key
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y --no-install-recommends yarn \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /etc/apt/sources.list.d/*
