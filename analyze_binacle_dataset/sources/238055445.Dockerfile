FROM seegno/bitcoind:0.13-alpine
# https://github.com/blockchain-certificates/cert-issuer/blob/master/Dockerfile
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories && \
    apk --update --no-cache add bash curl jq git python3
RUN git clone --depth=1 https://github.com/blockchain-certificates/cert-issuer.git /cert-issuer
RUN python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --upgrade pip setuptools \
    && mkdir -p /etc/cert-issuer/work \
    && mkdir -p /etc/cert-issuer/data/unsigned_certificates \
    && mkdir /etc/cert-issuer/data/signed_certificates \
    && mkdir /etc/cert-issuer/data/blockchain_certificates \
    && pip3 install /cert-issuer/. \
    && apk del py-pip \
    && rm -rf /var/cache/apk/* \
    && rm -rf /root/.cache
RUN cp /cert-issuer/conf_regtest.ini /etc/cert-issuer/conf.ini
ADD bitcoin.conf /root/.bitcoin/
ADD start.sh /start.sh
RUN chmod +x /start.sh
