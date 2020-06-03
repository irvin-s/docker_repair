FROM python:3.5

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY requirements.txt /usr/src/app
COPY requirements-dev.txt /usr/src/app
RUN pip install --no-cache-dir -r requirements-dev.txt

# vi: set ft=dockerfile :
