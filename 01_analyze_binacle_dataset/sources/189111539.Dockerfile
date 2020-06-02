FROM python:2.7-alpine
MAINTAINER Ory Band @ Rounds <ory@rounds.com>

# pip
# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION 8.1.0
RUN pip install -q --no-cache-dir --upgrade pip==$PYTHON_PIP_VERSION
