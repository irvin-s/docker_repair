FROM y12docker/dltdojo-bex
RUN apk --update --no-cache add python py-pip && \
    apk add --virtual .builddeps build-base musl-dev python-dev && \
    pip install --upgrade pip && \
    pip install pycrypto && pip install Crypto && \
    git clone --depth=1 https://github.com/bitcoin-abe/bitcoin-abe && \
    cd bitcoin-abe ; python setup.py install && \
    apk --no-cache --purge del .builddeps && \
    rm -rf /tmp/*
WORKDIR /bitcoin-abe
ADD abe-sqlite.conf ./
ADD start.sh /
RUN chmod a+x /start.sh
