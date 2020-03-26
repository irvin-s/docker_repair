#vim:set ft=dockerfile
FROM debian:jessie
MAINTAINER Julien Rouhaud <julien.rouhaud@dalibo.com>

WORKDIR /usr/local/src

RUN apt-get update && apt-get install -y \
    libpq5 \
    libpq-dev \
    python \
    python-dev \
    python-pip \
    && pip install powa-web \
    && apt-get purge -y --auto-remove libpq-dev python-dev python-pip \
    && rm -rf /var/lib/apt/lists/*

COPY powa-web.conf /etc/

EXPOSE 8888
CMD ["powa-web"]
