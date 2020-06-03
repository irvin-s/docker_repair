FROM python:2.7.13-jessie

MAINTAINER AutoQA Team

ENV LANG en_US.UTF-8
ENV TZ=Asia/Krasnoyarsk
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
    && apt-get install -y \
        bash \
        tzdata \
        ca-certificates \
        libssl-dev \
        libffi-dev \
        git \
        libpq-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /app
WORKDIR /app

COPY ./requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

COPY core /app/core
COPY migrations /app/migrations
COPY tests /app/tests
COPY vmmaster /app/vmmaster
COPY vmpool /app/vmpool
COPY ./tox.ini /app/tox.ini
COPY ./config_template.py /app/config.py
COPY ./config_template.py /app/tests/integrational/data/config.py
COPY ./manage.py /app/manage.py
COPY ./docker-entrypoint.sh /docker-entrypoint.sh

ENV PYTHONPATH /app
ENV PORT 9000

ARG APP_VERSION=dirty
ENV APP_VERSION ${APP_VERSION}

EXPOSE $PORT
CMD ["/bin/bash"]
ENTRYPOINT ["/docker-entrypoint.sh"]
