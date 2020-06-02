FROM node:11-alpine

COPY . /opt/sentry-sourcemaps

RUN \
  rm -rf /opt/sentry-sourcemaps/node_modules && \
  npm --loglevel=http --progress=false --color=false install -g --production /opt/sentry-sourcemaps

ENTRYPOINT ["sentry-sourcemaps"]
