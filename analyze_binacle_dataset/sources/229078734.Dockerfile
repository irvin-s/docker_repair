#
# Nova CLI Dockerfile
#

FROM python:2.7.12-alpine

RUN apk add --no-cache --virtual .pycrypto-build-deps \
       gcc \
       g++ \
       make \
       libffi-dev \
       openssl-dev \
       build-base \
    && apk add --no-cache git docker \
    && pip install -U gilt-nova \
    && git clone https://github.com/gilt/nova-shared-templates.git /nova-shared-templates \
    && ln -s /nova-shared-templates /root/.nova \
    && apk del .pycrypto-build-deps \
    && rm -rf ~/.cache

WORKDIR /root

ENTRYPOINT [ "nova" ]
