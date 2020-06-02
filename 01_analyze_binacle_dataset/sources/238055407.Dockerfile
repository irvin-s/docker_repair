FROM python:2.7-alpine
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/main" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories && \
    apk --update --no-cache add bash curl jq git bitcoin==0.13.1-r0 bitcoin-cli==0.13.1-r0 bitcoin-tx==0.13.1-r0 && \
    apk add --virtual .builddeps build-base musl-dev && \
    pip install pycrypto ; pip install Crypto && \
    git clone --depth=1 https://github.com/bitcoin-abe/bitcoin-abe && \
    cd bitcoin-abe ; python setup.py install && \
    apk del .builddeps
ADD bitcoin.conf /root/.bitcoin/
WORKDIR /bitcoin-abe
ADD abe-sqlite.conf ./
ADD start.sh /
RUN chmod a+x /start.sh
