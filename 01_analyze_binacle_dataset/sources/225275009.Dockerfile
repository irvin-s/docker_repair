FROM alpine:edge
RUN mkdir -p /usr/local/sbin \
    && echo http://nl.alpinelinux.org/alpine/edge/main | tee /etc/apk/repositories \
    && echo http://nl.alpinelinux.org/alpine/edge/testing | tee -a /etc/apk/repositories \
    && echo @community http://nl.alpinelinux.org/alpine/edge/community | tee -a /etc/apk/repositories \
    && apk add --update openssl \
    && wget -q -O /usr/local/sbin/apk-install https://raw.githubusercontent.com/gliderlabs/docker-alpine/master/builder/scripts/apk-install \
    && wget -q -O /usr/local/bin/owner https://raw.githubusercontent.com/colstrom/owner/master/bin/owner \
    && apk del openssl \
    && chmod a+x /usr/local/sbin/apk-install /usr/local/bin/owner

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base

RUN apk add --update bash
RUN apk add --update xvfb
RUN apk add --upgrade py-icu
RUN apk add --update py-qt
RUN apk add --update curl
RUN apk add --update mysql-client
RUN apk add --update git

RUN git clone git://github.com/adamn/python-webkit2png.git
WORKDIR python-webkit2png
RUN python setup.py install
WORKDIR /
RUN rm -rf python-webkit2png



ADD xvfb-run /usr/bin/
RUN chmod +x /usr/bin/xvfb-run
RUN rm -rf /var/cache/apk/*