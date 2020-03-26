FROM python:3.6-alpine

MAINTAINER denis@pubnative.net

RUN mkdir -p /opt/partition && \
  apk add --update \
    cyrus-sasl-dev \
    gcc \
    automake \
    g++ \
    openldap-dev \
    openssl-dev

RUN pip install thrift_sasl \
    sasl \
    toml \
    impyla \
    python-dateutil

COPY partition.py /opt/partition/partition.py

CMD ["/opt/partition/partition.py"]
