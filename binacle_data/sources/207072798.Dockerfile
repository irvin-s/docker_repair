FROM unocha/nodejs-base:%%UPSTREAM%%

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
      org.label-schema.name="nodejs" \
      org.label-schema.description="This service provides a nodejs service platform." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.6" \
      info.humanitarianresponse.nodejs="$NODE_VERSION" \
      info.humanitarianresponse.npm="$NPM_VERSION" \
      info.humanitarianresponse.yarn="$YARN_VERSION"

ENV NODE_APP_DIR=/srv/www \
    PORT=3000

COPY run_node package.json server.js /tmp/

WORKDIR "${NODE_APP_DIR}"

RUN mkdir -p /srv/www /srv/example /etc/services.d/node /root && \
    mv /tmp/run_node /etc/services.d/node/run && \
    mv /tmp/server.js /srv/example/ && \
    mv /tmp/package.json /srv/example/

EXPOSE ${PORT}

# mainly used to serve stuff so it makes sense to use ${NODE_APP_DIR} as WORKDIR
# but it doesnt make sense to make a volume out of it, unless you are doing it at runtime.
# VOLUME ["${NODE_APP_DIR}"]
