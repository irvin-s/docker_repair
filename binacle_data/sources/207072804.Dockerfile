FROM unocha/nodejs:%%UPSTREAM%%

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
      org.label-schema.name="nodejs-hid" \
      org.label-schema.description="This service provides a nodejs platform for HIDv2." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.6" \
      info.humanitarianresponse.nodejs="$NODE_VERSION" \
      info.humanitarianresponse.npm="$NPM_VERSION" \
      info.humanitarianresponse.yarn="$YARN_VERSION" \
      info.humanitarianresponse.vips="8.6.1"

RUN \
    apk add --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
      build-base fftw-dev vips-dev vips-tools && \
    SHORT_VERSION=$(echo ${VERSION} | sed 's/-.*//g') && \
    mkdir -p /root/.node-gyp/${SHORT_VERSION} && \
    USER=root npm install -g sharp --unsafe-perm && \
    apk del build-base fftw-dev vips-dev && \
    rm -rf /var/cache/apk/* /root/.npm /root/.node-gyp

# inherits also as volumes SRC_DIR=/src and $NODE_APP_DIR=/srv/www
# we'd better NOT expose this as a volume, unless we really intend mapping to a host folder
# in which case we can just skip exposing it.
# VOLUME ["${DST_DIR}"]
