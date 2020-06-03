FROM python:3.6-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
        python2.7 python-pip build-essential \
        && rm -r /var/lib/apt/lists/*

# Create user
ARG uid=1000
ARG gid=1000

# Create user if not exists
RUN getent group $gid || groupadd --gid $gid pynesis
RUN getent passwd $uid || useradd -m -u $uid -g $gid pynesis

RUN mkdir -p /code/.tox

RUN chown -R $uid:$gid /usr/local /code
RUN pip install -U pip setuptools wheel tox mypy
RUN pip2 install -U pip setuptools wheel tox

USER $uid
WORKDIR /code
