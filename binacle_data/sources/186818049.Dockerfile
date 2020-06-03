FROM python:2.7.16-alpine3.9

LABEL authors="certator@gmail.com"

RUN mkdir /app
WORKDIR /app

COPY *requirements.txt /app/

RUN pip install --upgrade pip
RUN pip install -r /app/requirements.txt

COPY . /app
