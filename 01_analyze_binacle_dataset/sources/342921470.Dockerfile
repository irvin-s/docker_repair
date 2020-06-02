FROM python:3.6.3-slim

WORKDIR /opt/demo

COPY requirements.txt ./

RUN set -x \
    && apt-get update \
    && apt-get install -y --no-install-recommends build-essential libev-dev git \
    && pip install --no-cache-dir -r requirements.txt \
    && apt-get purge -y --auto-remove build-essential

ADD app.py ./
ADD runner.py ./
