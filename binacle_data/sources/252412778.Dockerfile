FROM python:2.7-alpine
MAINTAINER Nick Wood <nick.wood@upguard.com>

RUN mkdir -p /usr/src/app/slackbot

COPY ./slackbot /usr/src/app/slackbot
COPY ./requirements.txt /usr/src/app
COPY ./run.py /usr/src/app
WORKDIR /usr/src/app

RUN pip install -r ./requirements.txt

CMD [ "python", "./run.py" ]
