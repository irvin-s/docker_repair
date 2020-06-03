FROM mhart/alpine-node:8

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh python build-base

RUN addgroup -S app && adduser -S -G app app

USER app
WORKDIR /app

RUN mkdir /home/app/.npm-global
ENV PATH=/home/app/.npm-global/bin:$PATH
ENV NPM_CONFIG_PREFIX=/home/app/.npm-global

RUN npm i -g -s @ethereum-alarm-clock/cli
ARG WALLET
COPY ${WALLET} /app
ENV WALLET $WALLET

RUN cd /app

CMD ["sh", "-c", "eac timenode --docker --claiming --usingSmartGasEstimation --autostart --logFile console --logLevel 1 --wallet ${WALLET} --password ${PASSWORD} --providers ${PROVIDER}"]
