FROM alpine:edge

RUN apk --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ add \
 nodejs nodejs-npm chromium firefox xwininfo xvfb dbus eudev ttf-freefont fluxbox libc6-compat

WORKDIR /opt/systac
RUN adduser -D -h /opt/systac user
USER user

COPY ./package.json /opt/systac/package.json
COPY ./package-lock.json /opt/systac/package-lock.json

RUN npm install \
    && npm cache clean --force \
    && rm -rf /tmp/*

ENV NODE_PATH=/opt/systac/node_modules

USER root
COPY ./docker/docker-entrypoint.sh /opt/systac/
COPY ./cucumber.js /opt/systac/
RUN chmod +x /opt/systac/docker-entrypoint.sh

ENV SCREEN_WIDTH=1280
ENV SCREEN_HEIGHT=720

VOLUME ["/opt/systac/e2e"]
USER user
ENTRYPOINT ["/opt/systac/docker-entrypoint.sh"]
CMD [ "npm", "run", "e2e-test"]
