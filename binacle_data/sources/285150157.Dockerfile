FROM python:3.6-slim-stretch

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      libcurl4-openssl-dev \
      libssl-dev \
      build-essential \
      && \
    apt-get purge && apt-get clean

RUN pip3 install --no-cache-dir tornado ruamel.yaml oauthlib psycopg2 pycurl

RUN mkdir -p /srv/hubsharder
ADD sharder.py /srv/hubsharder/sharder.py
ADD ltivalidator.py /srv/hubsharder/ltivalidator.py
ADD request-sharder.py /srv/hubsharder/request-sharder.py

WORKDIR /srv/hubsharder