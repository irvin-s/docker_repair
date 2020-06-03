FROM python:3.6-alpine
LABEL maintainer="Ocean Protocol <devops@oceanprotocol.com>"

RUN apk add --no-cache --update\
    build-base \
    gcc \
    gettext\
    gmp \
    gmp-dev \
    libffi-dev \
    openssl-dev \
    py-pip \
    python3 \
    python3-dev \
  && pip install virtualenv

COPY . /mantaray
WORKDIR /mantaray
RUN mkdir /test_logs

# Install packages
RUN pip install mantaray-utilities
RUN pip install schedule
RUN pip install squid-py==0.5.11 --ignore-installed

ENV USE_K8S_CLUSTER='true'
ENV DOCKER_START_TIME='now'
ENV DOCKER_END_TIME='20:00'
ENV DOCKER_INTERVAL='30'
ENV DOCKER_PUBLISHER_ADDR='0x413c9BA0A05B8A600899B41b0c62dd661e689354'
ENV DOCKER_PUBLISHER_PASS='ocean_secret'
ENV DOCKER_CONSUMER_ADDR='0x06C0035fE67Cce2B8862D63Dc315D8C8c72207cA'
ENV DOCKER_CONSUMER_PASS='ocean_secret'

ENTRYPOINT ["/mantaray/docker-entrypoint.sh"]

# RUN pip install --force-reinstall --ignore-installed git+https://github.com/oceanprotocol/mantaray_utilities.git

