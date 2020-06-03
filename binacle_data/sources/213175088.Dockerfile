FROM python:3-onbuild

COPY . /usr/src/pybot

WORKDIR /usr/src/pybot

CMD bin/pybot telegram 
