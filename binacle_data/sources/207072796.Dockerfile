FROM unocha/debian-base-s6:%%UPSTREAM%%

# Parse arguments for the build command.
ARG NODE_VERSION=8.11.2
ARG NPM_VERSION=5.6.0
ARG YARN_VERSION=1.6.0
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

ENV NODE_VERSION=$NODE_VERSION \
    YARN_VERSION=$YARN_VERSION \
    NPM_VERSION=$NPM_VERSION \
    NODE_APP_DIR=/srv/www \
    NODE_PATH=/usr/lib/node_modules:/usr/local/lib/node_modules:/usr/local/share/.config/yarn/global/node_modules \
    NPM_CONFIG_SPIN=false \
    NPM_CONFIG_PROGRESS=false \
    SRC_DIR=/src \
    NEW_RELIC_HOME=/srv/ \
    NEW_RELIC_LOG_LEVEL=info \
    NEW_RELIC_LICENSE_KEY=aaa \
    NEW_RELIC_APP_NAME=nodeapp \
    NEW_RELIC_NO_CONFIG_FILE=True


# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="nodejs-base" \
      org.label-schema.description="This service provides a base nodejs platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Debian Linux" \
      org.label-schema.distribution-version="8-slim" \
      info.humanitarianresponse.nodejs="$NODE_VERSION" \
      info.humanitarianresponse.npm="$NPM_VERSION" \
      info.humanitarianresponse.yarn="$YARN_VERSION"

#RUN groupadd --gid 1000 node \
#  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

# gpg keys listed at https://github.com/nodejs/node#release-team
RUN set -ex \
    && for key in \
        94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
        FD3A5288F042B6850C66B31F09FE44734EB7990E \
        71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
        DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
        C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
        B9AE9905FFD7803F25714661B63B535A4C206CA9 \
        56730D5401028683275BD23C23EFEFE93C4CFFFE \
        77984A986EBC2AA786BC0F66B01FBB92821C587A \
    ; do \
        gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
        gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
        gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
    done

RUN buildDeps='xz-utils' && \
    ARCH='x64' && \
    set -x && \
    apt-get update && apt-get install -y ca-certificates curl wget $buildDeps --no-install-recommends && \
    rm -rf /var/lib/apt/lists/* && \
    curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-$ARCH.tar.xz" && \
    curl -fsSLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" && \
    gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc && \
    grep " node-v$NODE_VERSION-linux-$ARCH.tar.xz\$" SHASUMS256.txt | sha256sum -c - && \
    tar -xJf "node-v$NODE_VERSION-linux-$ARCH.tar.xz" -C /usr/local --strip-components=1 --no-same-owner && \
    rm "node-v$NODE_VERSION-linux-$ARCH.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt && \
    apt-get purge -y --auto-remove $buildDeps && \
    ln -s /usr/local/bin/node /usr/local/bin/nodejs

RUN set -ex && \
    for key in \
        6A010C5166006599AA17F08146C2130DFD2497F5 \
    ; do \
        gpg --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys "$key" || \
        gpg --keyserver hkp://ipv4.pool.sks-keyservers.net --recv-keys "$key" || \
        gpg --keyserver hkp://pgp.mit.edu:80 --recv-keys "$key" ; \
    done && \
    curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" && \
    curl -fsSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" && \
    gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz && \
    mkdir -p /opt && \
    tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/ && \
    ln -s /opt/yarn-v$YARN_VERSION/bin/yarn /usr/local/bin/yarn && \
    ln -s /opt/yarn-v$YARN_VERSION/bin/yarnpkg /usr/local/bin/yarnpkg && \
    rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz

RUN yarn global add \
      grunt-cli \
      newrelic

RUN rm -rf /var/lib/apt/lists/* && \
    mkdir -p /tmp && \
    chmod 1777 /tmp && \
    mkdir -p ${SRC_DIR} ${NODE_APP_DIR} && \
    cp -a /usr/local/share/.config/yarn/global/node_modules/newrelic/newrelic.js /srv

##############


# RUN  apk add --no-cache \
#         libstdc++ \
#   && apk add --no-cache \
#         curl \
#         git \
#   && apk add --no-cache --virtual .build-deps \
#         bash \
#         binutils-gold \
#         build-base \
#         gnupg \
#         linux-headers \
#         perl \
#         python \
#   # gpg keys listed at https://github.com/nodejs/node#release-team
#   && for key in \
#     94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
#     FD3A5288F042B6850C66B31F09FE44734EB7990E \
#     71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
#     DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
#     C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
#     B9AE9905FFD7803F25714661B63B535A4C206CA9 \
#     56730D5401028683275BD23C23EFEFE93C4CFFFE \
#     77984A986EBC2AA786BC0F66B01FBB92821C587A \
#   ; do \
#     gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
#     gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
#     gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
#   done \
#     && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" \
#     && curl -SLO --compressed "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
#     && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
#     && grep " node-v$NODE_VERSION.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
#     && tar -xf "node-v$NODE_VERSION.tar.xz" \
#     && cd "node-v$NODE_VERSION" \
#     && ./configure --prefix=/usr --without-npm \
#     && make -j$(getconf _NPROCESSORS_ONLN) \
#     && make install \
#     && cd .. \
#     && rm -Rf "node-v$NODE_VERSION" \
#     && rm "node-v$NODE_VERSION.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
#     && for key in \
#     6A010C5166006599AA17F08146C2130DFD2497F5 \
#   ; do \
#     gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
#     gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
#     gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
#   done \
#   && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz" \
#   && curl -fSLO --compressed "https://yarnpkg.com/downloads/$YARN_VERSION/yarn-v$YARN_VERSION.tar.gz.asc" \
#   && gpg --batch --verify yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
#   && mkdir -p /opt/yarn \
#   && tar -xzf yarn-v$YARN_VERSION.tar.gz -C /opt/yarn --strip-components=1 \
#   && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarn \
#   && ln -s /opt/yarn/bin/yarn /usr/local/bin/yarnpkg \
#   && rm yarn-v$YARN_VERSION.tar.gz.asc yarn-v$YARN_VERSION.tar.gz \
#   && yarn global add \
#         grunt-cli \
#         newrelic \
#   && yarn cache clean \
#   && cd /tmp \
#   && curl https://codeload.github.com/npm/npm/tar.gz/v${NPM_VERSION} -o npm.tgz \
#   && tar xvzf npm.tgz \
#   && cd npm-${NPM_VERSION} \
#   && make install \
#   && apk del .build-deps \
#   && rm -rf \
#         /usr/lib/node_modules/npm/man \
#         /usr/lib/node_modules/npm/doc \
#         /usr/lib/node_modules/npm/html \
#         /usr/lib/node_modules/npm/scripts \
#         /tmp \
#   &&  rm -rf /var/cache/apk/* \
