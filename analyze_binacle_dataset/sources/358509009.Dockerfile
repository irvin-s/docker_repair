FROM alpine

MAINTAINER Zongmin Lei <leizongmin@gmail.com>

RUN apk update && apk upgrade
RUN apk add python
RUN apk add curl

RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "/tmp/get-pip.py"
RUN python "/tmp/get-pip.py"

RUN pip install --upgrade pip
RUN pip install shadowsocks

ENV SS_PASSWORD 1234567
ENV SS_METHOD aes-256-cfb

ENTRYPOINT /usr/bin/ssserver -k ${SS_PASSWORD} -m ${SS_METHOD}
EXPOSE 8388
