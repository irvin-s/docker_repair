FROM anapsix/alpine-java:8

RUN apk upgrade --update && \
    apk add --update curl && \
    curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein && \
    chmod 755 ./lein && \
    cp ./lein /usr/bin && \
    lein

ADD websocket /src/websocket
ENV LEIN_ROOT 1
WORKDIR /src/websocket

RUN lein deps

EXPOSE 8081
CMD lein run
