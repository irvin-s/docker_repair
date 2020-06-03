FROM frolvlad/alpine-java:jre8-slim
LABEL author="TestingBot <info@testingbot.com>"

RUN addgroup -S bot \
    && adduser -S -G bot bot

ENV HOME=/home/bot

ARG TUNNEL=testingbot-tunnel

RUN apk add --no-cache --virtual .build-deps curl \
    && curl https://testingbot.com/downloads/${TUNNEL}.zip | unzip -d ${HOME} - \
    && chown -R bot:bot ${HOME}/${TUNNEL} \
    && apk del .build-deps

USER bot

WORKDIR ${HOME}/${TUNNEL}

ENTRYPOINT ["java", "-jar", "testingbot-tunnel.jar"]
