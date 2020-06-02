#FROM python:3.5-alpine
FROM bamx23/scipy-alpine:latest
MAINTAINER Leanid Vouk "bexpace@gmail..com"

# make sure the package repository is up to date
RUN apk update && apk upgrade
RUN apk add bash
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

ENV LC_ALL=en_US.UTF-8
WORKDIR /root

#RUN apk --no-cache add ca-certificates
RUN apk add --no-cache build-base
RUN apk add --update \
    build-base\
    python-dev\
    openssl-dev\
    libffi-dev\
    libxml2-dev\
    libxslt-dev\
  && pip install --upgrade pip\
  && pip install setuptools\
  && rm -rf /var/cache/apk/*

COPY . /root/app
WORKDIR /root/app


RUN pip install -r requirements.txt
EXPOSE 8080
CMD ["python", "app.py"]
