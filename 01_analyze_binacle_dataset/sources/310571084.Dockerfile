FROM chrisdlangton/hardened-node-alpine:0.0.1
LABEL author="github.com/chrisdlangton"

ENV PHASER_VERSION 3.9.0
ENV PHASER_PORT 3000
ENV PHASER_INDEX src/index.html
ENV NODE_ENV development
ENV STATIC_SERVER_ARGS ""

RUN npm i -g generator-phaser-plus@3.0.0-beta.1 static-server@2.2 es6-module-transpiler@0.10 \
    --no-optional --no-package-lock && \
    apk update \
    && apk add --no-cache --update git curl bash \
    && rm -rf /tmp/ \
    && rm -rf /var/cache/apk/*

RUN adduser -s /usr/local/bin/node -h /phaser -G node -S -D phaser
WORKDIR /phaser
USER phaser

COPY package.json .
RUN npm i phaser@${PHASER_VERSION} --no-optional --no-package-lock \
# Install photonstorm/phaser3-project-template to /phaser/boilerplate
 && git clone https://github.com/photonstorm/phaser3-project-template.git /phaser/boilerplate && \
    cd /phaser/boilerplate && \
    npm i --no-optional --no-package-lock

HEALTHCHECK --interval=10s --timeout=3s --start-period=3s \
    CMD curl --silent --fail http://localhost:${PHASER_PORT}/ || exit 1

# Expose webpack server on 8080
EXPOSE 8080
# Expose static web server
EXPOSE $PHASER_PORT
VOLUME [ "/phaser/src", "/phaser/assets" ]
CMD [ "bash", "-c", "static-server -p ${PHASER_PORT} -i ${PHASER_INDEX} ${STATIC_SERVER_ARGS}" ]
