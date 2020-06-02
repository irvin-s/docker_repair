FROM node:7-alpine
# https://github.com/lwmqn/lwmqn-demo
RUN apk --update --no-cache add bash curl jq git && \
    apk add --virtual .builddeps build-base python musl-dev && \
    git clone --depth=1 https://github.com/lwmqn/lwmqn-demo.git && \
    cd lwmqn-demo && npm install && \
    apk apk --no-cache --purge del .builddeps
WORKDIR /lwmqn-demo
