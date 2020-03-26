FROM python:2.7-slim

MAINTAINER Tim Co <tim@pinn.ai>

RUN adduser --system celery

COPY worker.sh /
RUN chmod 777 worker.sh

WORKDIR /usr/src/worker/

COPY requirements.txt .
RUN pip install -r requirements.txt
RUN mkdir -p log
RUN chmod 777 -R .

WORKDIR /var/www/app
