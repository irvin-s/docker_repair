FROM python:3.6.2-alpine3.6
LABEL maintainer="Datadog Inc. <manu@datadoghq.com>"

COPY requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
