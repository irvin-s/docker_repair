FROM tiangolo/uwsgi-nginx-flask:python3.6-alpine3.7

RUN apk add --update --no-cache \
    python \
    python-dev \
    py-pip \
    build-base \
    bash \
    libressl \
    libressl-dev \
  && pip install virtualenv \
  && rm -rf /var/cache/apk/*

COPY requirements.txt /
RUN pip install -r /requirements.txt

RUN ln -sf /app/app/rpc.swagger.json /app/rpc.swagger.json

COPY ./app /app
