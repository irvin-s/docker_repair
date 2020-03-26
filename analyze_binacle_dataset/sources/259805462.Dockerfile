FROM python:3.6-alpine

RUN apk update
RUN apk --no-cache add openssl-dev gcc libffi-dev linux-headers musl-dev
RUN pip install setuptools prometheus_client google-api-python-client cryptography cffi pyOpenSSL

ENV BIND_PORT 9173
ENV START_DATE "2008-01-01"
ENV ACCOUNT_EMAIL "Replace@Me"
ENV VIEW_ID "12345678"

ADD . /usr/src/app
WORKDIR /usr/src/app

CMD ["python", "gar_exporter.py"]
