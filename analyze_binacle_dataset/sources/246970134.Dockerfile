# Dockerfile for py-kms

FROM python:2-alpine
MAINTAINER Matsuz <xiangsong.zeng@gmail.com>

ADD . /kms

EXPOSE 1688

CMD ["python", "/kms/server.py"]
