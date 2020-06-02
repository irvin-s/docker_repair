FROM node:8.1-slim

# get dependencies
ADD package.json /tmp/app-dev/package.json
RUN cd /tmp/app-dev && npm install --only=dev
RUN mkdir /tmp/app && cp /tmp/app-dev/package.json /tmp/app/ && \
  cd /tmp/app && npm install --only=production

# build
ADD ./src /tmp/app-dev/src
ADD ./.babelrc /tmp/app-dev/.babelrc
RUN /tmp/app-dev/node_modules/.bin/babel /tmp/app-dev/src/ -d /tmp/app/dist --copy-files --ignore public/ && \
  cp -r /tmp/app-dev/src/endpoints/directory_gui/public /tmp/app/dist/endpoints/directory_gui && \
  rm /tmp/app/package-lock.json

FROM node:8.1-slim

EXPOSE 3000 4000
WORKDIR /opt/app

ENV NPM_CONFIG_LOGLEVEL warn

COPY --from=0 /tmp/app/ /opt/app

CMD npm start