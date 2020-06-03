FROM python:3.6-alpine3.7

RUN apk add --update tini
RUN apk add --update git
RUN apk add --update build-base

ENV PIPENV_VENV_IN_PROJECT=1
ENV PIPENV_IGNORE_VIRTUALENVS=1
ENV PIPENV_NOSPIN=1
ENV PIPENV_HIDE_EMOJIS=1
ENV PYTHONPATH=/jinjabread

RUN pip install pipenv

RUN mkdir -p /jinjabread
COPY . /jinjabread
WORKDIR /jinjabread

RUN pipenv sync

EXPOSE 80

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["pipenv", "run", "start"]
