FROM tiangolo/uvicorn-gunicorn:python3.7

LABEL maintainer="Sebastian Ramirez <tiangolo@gmail.com>"

RUN pip install starlette

COPY ./app /app
