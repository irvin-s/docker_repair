FROM python:3.6-slim

RUN apt-get update -y \
  && apt-get install --no-install-recommends -y memcached rabbitmq-server redis-server
