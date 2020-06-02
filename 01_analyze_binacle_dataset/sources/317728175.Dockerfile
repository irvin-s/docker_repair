FROM node:9.2.1 as installer

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN npm install -g -s --no-progress yarn node-gyp && \
    yarn && \
    npm rebuild node-sass --force

ENV API_HOST="api.containerum.io" \
    API_PROTOCOL_TYPE="ssl" \
    API_PORT="8082" \
    COUNTRY="US" \
    RECAPTCHA="6LejdSMUAAAAADNv4yBEqxz4TAyXEIYCbwphVSDS" \
    LATEST_RELEASE=""

RUN yarn build

EXPOSE 3000

CMD yarn start:prod:docker
