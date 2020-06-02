FROM alpine:3.4

RUN apk add --no-cache --virtual=build-dependencies curl \
    && apk add --no-cache bash \
    \
    && curl -sSL -o /peer-finder https://storage.googleapis.com/kubernetes-release/pets/peer-finder \
    && chmod +x /peer-finder \
    \
    && apk del build-dependencies \
    && rm -rf /tmp/*

ENTRYPOINT ["/peer-finder"]