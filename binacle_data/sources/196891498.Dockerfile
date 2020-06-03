FROM python:3-onbuild

MAINTAINER Mikhail Simin

COPY ./ /app/

RUN pip install -e /app
