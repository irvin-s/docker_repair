FROM alpine:3.4
MAINTAINER janes - https://github.com/hxer

ENV PACKAGES="\
  python \
  py-pip \
  uwsgi-python \
  supervisor \
"

ENV PY_PACKAGES="\
  django==1.8.10 \
  django-pagination \
  pymongo \
  mongoengine \
"

COPY nginx.conf /etc/nginx/nginx.conf
COPY supervisord.conf /etc/supervisord.conf

RUN apk update && \
    apk add $PACKAGES && \
    pip install --upgrade pip && \
    pip install $PY_PACKAGES && \
    mkdir /www

WORKDIR /www

CMD ['supervisord']
