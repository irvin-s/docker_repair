FROM unocha/alpine-base-s6:%%UPSTREAM%%

MAINTAINER Serban Teodorescu <teodorescu.serban@gmail.com>

# Parse arguments for the build command.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="alpine-base-nodejs" \
      org.label-schema.description="This service provides a base nodejs platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.6" \
      info.humanitarianresponse.nodejs="6.11.4-r0"

ENV NODE_APP_DIR=/srv/www \
    NODE_PATH=/usr/lib/node_modules \
    NPM_CONFIG_SPIN=false \
    NPM_CONFIG_PROGRESS=false \
    SRC_DIR=/src \
    NEW_RELIC_HOME=/srv/ \
    NEW_RELIC_LOG_LEVEL=info \
    NEW_RELIC_LICENSE_KEY=aaa \
    NEW_RELIC_APP_NAME=nodeapp \
    NEW_RELIC_NO_CONFIG_FILE=True

RUN apk add --update-cache \
        build-base \
        git \
        python && \
    apk add --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
        nodejs \
        nodejs-npm && \
    mkdir -p /root/.node-gyp/6.11.4 && \
    USER=root npm install -g \
        grunt-cli \
        bower \
        newrelic \
        webpack \
        yarn && \
    npm cache clean && \
    rm -rf /tmp /root/.node-gyp && \
    apk del build-base && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /tmp && \
    chmod 1777 /tmp && \
    mkdir -p ${SRC_DIR} ${NODE_APP_DIR} && \
    cp -a /usr/lib/node_modules/newrelic/newrelic.js /srv

#define the volumes at run time - far better
#VOLUME ["${SRC_DIR}", "${NODE_APP_DIR}"]

# mainly used to build stuff so it makes sense to use ${SRC_DIR} as WORKDIR
# but we let the downstream images to decide
#WORKDIR ${SRC_DIR}
