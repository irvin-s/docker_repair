# Gulp v3.9.1

FROM node:10.1.0-alpine

ENV GULP_VERSION=3.9.1 \
    DOCKER_VERSION=18.03.1-ce

RUN apk --no-cache add tini ca-certificates \
    && yarn global add "gulp@${GULP_VERSION}" \
    && rm -rf /usr/local/share/.cache/yarn \
    && find / -depth -type d -name test* -exec rm -rf {} \; \
    && find / -depth -type f -name *.md -exec rm -f {} \; \
    && find / -depth -type f -name *.yml -exec rm -f {} \;

RUN apk --no-cache add --virtual build-deps curl \
    && curl --location --silent --show-error -O \
        https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz \
    && tar xzf docker-${DOCKER_VERSION}.tgz \
    && cp docker/docker /usr/bin/docker \
    && rm -rf /docker* .dockerenv \
    && apk del --purge -r build-deps

WORKDIR /gulp

ADD package.json /gulp/package.json
RUN apk add --no-cache --virtual build-deps make g++ python-dev \
    && yarn add package.json \
    && rm -rf /usr/local/share/.cache/yarn \
    && find / -depth -type f -name *.md -exec rm -f {} \; \
    && find / -depth -type f -name *.yml -exec rm -f {} \; \
    && apk del --purge -r build-deps

VOLUME /monitor
ADD sample-gulpfile.js /gulp/gulpfile.js
ADD sample-eslint.json /gulp/eslint.json

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["gulp"]
