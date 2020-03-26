FROM ubuntu
MAINTAINER rail@mozilla.com
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -q update \
    && apt-get install --yes -q \
    libmysqlclient-dev \
    npm \
    phantomjs \
    python-tox \
    python-dev \
    sqlite3 \
    && apt-get clean

COPY Dockerfile-tests /Dockerfile
