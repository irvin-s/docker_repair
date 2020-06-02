FROM python:3.6-alpine

ENV PYTHONUNBUFFERED 1

RUN mkdir /app
WORKDIR /app

ADD requirements.txt /app
RUN apk update \
 && apk add --virtual build-deps gcc python-dev musl-dev linux-headers \
 && apk add postgresql-dev
RUN pip install --no-cache-dir -r requirements.txt

ADD app /app/
