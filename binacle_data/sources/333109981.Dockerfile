FROM mhart/alpine-node:8

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh python build-base

WORKDIR /app
COPY wallet.json /app

RUN npm install -g --unsafe-perm eac.js

CMD ["sh", "-c", "eac.js -c --autostart -w wallet.json -p ${PASSWORD} --provider ${PROVIDER}"]