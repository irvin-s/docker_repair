FROM python:2.7

RUN mkdir -p /usr/testhost && chmod 700 /usr/testhost && \
    mkdir /usr/testguest && chmod 777 /usr/testguest

COPY . /usr/testhost/
