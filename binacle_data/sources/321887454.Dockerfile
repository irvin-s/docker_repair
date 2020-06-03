FROM python:3.7-stretch

RUN apt-get update && \
    apt-get install -y --no-install-recommends python-pip zip && \
    rm -rf /var/lib/apt/lists/* && \
    pip install awscli

WORKDIR /app