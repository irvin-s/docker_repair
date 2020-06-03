FROM python:2.7

MAINTAINER rail@mozilla.com

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -q update && \
    apt-get -q --yes install \
        sqlite3 \
        default-libmysqlclient-dev \
        mysql-client \
    && apt-get clean

WORKDIR /app

COPY . /app
WORKDIR /app
RUN pip install -r requirements/compiled.txt -r requirements/dev.txt -r requirements/prod.txt
