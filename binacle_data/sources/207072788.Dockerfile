FROM unocha/alpine-base-s6:%%UPSTREAM%%

# Parse arguments for the build command.
ARG NODE_VERSION=8.11.3-r1
ARG NPM_VERSION=8.11.3-r1
ARG YARN_VERSION=1.7.0-r0
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
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.8" \
      info.humanitarianresponse.nodejs="$NODE_VERSION" \
      info.humanitarianresponse.npm="$NPM_VERSION" \
      info.humanitarianresponse.yarn="$YARN_VERSION"

RUN  apk add --no-cache \
        libstdc++ \
  && apk add --no-cache \
        curl \
        git \
  && apk add --no-cache \
        nodejs \
        nodejs-npm \
        yarn \
  && yarn global add \
        grunt-cli \
        newrelic \
  && yarn cache clean \
  &&  rm -rf /var/cache/apk/* \
  &&  mkdir -p /tmp \
  &&  chmod 1777 /tmp \
  &&  mkdir -p ${SRC_DIR} ${NODE_APP_DIR} \
  &&  cp -a /usr/local/share/.config/yarn/global/node_modules/newrelic/newrelic.js /srv
