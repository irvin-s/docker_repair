FROM python:2.7.13-alpine

MAINTAINER Ajay<ajay_886@hotmail.com>

ARG APP_PATH=/sbin/alert

RUN mkdir -p ${APP_PATH}/rules

COPY ./rules/ ${APP_PATH}/rules
COPY ./requirements.txt ${APP_PATH}
COPY ./entrypoint.sh ${APP_PATH}
COPY ./config.yaml.tmpl ${APP_PATH}

WORKDIR ${APP_PATH}

RUN apk --update add --virtual build-dependencies libffi-dev openssl-dev python-dev build-base \
  && pip install -r requirements.txt \
  && apk del build-dependencies

CMD ["/sbin/alert/entrypoint.sh"]

