FROM python:3.6.4-alpine

MAINTAINER Karol Gil <karol.gil@getbase.com>

ENV APP=/usr/src/triggear
RUN mkdir -p $APP
WORKDIR $APP

RUN pip install pipenv
COPY . $APP
RUN pipenv install

ENV CREDS_PATH=$APP/configs/creds.yml
ENV CONFIG_PATH=$APP/config.yml

ENV MONGO_URL="localhost:27017"
RUN pipenv run py.test --cov-report=html --cov=app --junit-xml=report.xml .