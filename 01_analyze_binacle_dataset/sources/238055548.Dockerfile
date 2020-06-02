FROM node:7-alpine
# https://github.com/ethereumproject/explorer
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories && \
    echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk upgrade --update
RUN apk --update --no-cache add bash curl jq git mongodb
#
WORKDIR /opt/app/explorer
RUN cd /opt/app && git clone --depth=1 https://github.com/ethereumproject/explorer.git explorer && \
    cd explorer && npm install
ADD config.json tools/
ADD start.sh /
RUN chmod a+x /start.sh
# mongod
VOLUME /data/db
