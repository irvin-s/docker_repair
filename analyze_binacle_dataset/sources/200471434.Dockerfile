FROM python:2-alpine

RUN pip install requests \
  && pip install cloudflare
