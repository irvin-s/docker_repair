FROM docker:stable

VOLUME /app

ENV PYTHONUNBUFFERED 1

RUN apk upgrade --no-cache \
    && apk add --no-cache --update git python3

COPY requirements.txt /
RUN pip3 install --upgrade pip \
    && pip install -r /requirements.txt \
    && rm -rf /root/.cache/pip/wheels/*

WORKDIR /app

ARG STAGE
ARG BASE_DIR
ENV CONTAINER_BUILD_STAGE=$STAGE
ENV MLSPLOIT_DOCKER_HOST_BASE_DIR=$BASE_DIR

ENTRYPOINT sh entrypoint-${CONTAINER_BUILD_STAGE}.sh
