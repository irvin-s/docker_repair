FROM frolvlad/alpine-python3
MAINTAINER james.mclean@gmail.com

COPY requirements.txt /tmp/requirements.txt
COPY test-requirements.txt /tmp/test-requirements.txt

RUN apk add --update \
    git

RUN pip install --upgrade pip \
    && pip install -r /tmp/test-requirements.txt \
    && pip install pep8


