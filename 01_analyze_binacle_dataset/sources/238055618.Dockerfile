FROM node:7-alpine
# https://github.com/iquidus/explorer
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories && \
    echo http://dl-4.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
    apk upgrade --update
RUN apk --update --no-cache add bash curl jq git mongodb bitcoin==0.13.1-r0 bitcoin-cli==0.13.1-r0 bitcoin-tx==0.13.1-r0
#
WORKDIR /opt/app/explorer
RUN cd /opt/app && git clone --depth=1 https://github.com/iquidus/explorer explorer && \
    cd explorer && npm install --production
ADD settings.json .
ADD bitcoin.conf /root/.bitcoin/
ADD start.sh /
RUN chmod a+x /start.sh
# mongod
VOLUME /data/db
