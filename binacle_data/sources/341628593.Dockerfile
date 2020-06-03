FROM alpine:node

WORKDIR /tmp/app

RUN apk add --no-cache \
      tini && \
    apk add --no-cache --virtual build-deps \
      build-tools

COPY . .

RUN mv docker/entrypoint.sh /usr/sbin && \
    yarn && \
    yarn build && \
    mv dist/web /opt/app && \
    mv package.json yarn.lock node_modules /opt/app

WORKDIR /opt/app

RUN yarn && \
    rm -rf /tmp/app && \
    apk clean build-deps

ENTRYPOINT ["/usr/sbin/tini", "--", "/bin/sh", "/usr/sbin/entrypoint.sh"]
