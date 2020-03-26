FROM python:3.7-alpine
ENV PYTHONUNBUFFERED 1
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY Pipfile /usr/src/app/
RUN apk update \
  && apk add --virtual build-tools gcc python3-dev musl-dev \
  && apk add postgresql-dev
RUN pip install pipenv
RUN pipenv lock --pre
RUN pipenv install --system --dev
RUN pipenv install --system --deploy
RUN apk del build-tools
ADD . /usr/src/app/
