FROM python:3.7

RUN pip install pytest

WORKDIR /me

ADD ./*.py ./
