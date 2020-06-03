FROM orbs:base-sdk

ADD . /opt/orbs

RUN ./build-bot.sh && yarn cache clean
