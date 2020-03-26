FROM python:3.7.2-slim

WORKDIR /opt

ADD Pipfile Pipfile
ADD Pipfile.lock Pipfile.lock

RUN apt-get update -y && \
    apt-get install -y build-essential && \
    pip install -U pip && \
    pip install -U pipenv && \
    pipenv install --system --dev --deploy && \
    apt-get remove -y build-essential && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD scrapy.cfg scrapy.cfg
ADD cicero /opt/cicero
