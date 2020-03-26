FROM ubuntu:bionic

MAINTAINER tchoedak <tchoedak@gmail.com>

ARG SMTP_USERNAME
ARG SMTP_PASSWORD
ARG SELLER_CENTRAL_ACCESS_KEY_ID
ARG SELLER_CENTRAL_SECRET_KEY
ARG ANOTI_NUMBER
ARG ACCOUNT_SID
ARG AUTH_TOKEN

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    cron \
    vim \
    build-essential \
    python-dev \
    python3-dev \
    python3.7 \
    python3.7-dev \
    libsasl2-dev \
    python-setuptools \
    python3.7-distutils \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
RUN python3.7 get-pip.py --disable-pip-version-check --no-cache-dir pip setuptools;

RUN python3.7 -m pip install -U pip --no-cache-dir
RUN pip3 install -U pip --no-cache-dir

RUN cp /usr/local/bin/pip3.7 /usr/local/bin/pip
RUN cd /usr/bin && ln -sf python3.7 python3
RUN cd /usr/bin && ln -sf python3.7m python3m

ADD requirements.txt /tmp/requirements.txt
RUN pip3 install virtualenv
RUN virtualenv --python=python3 venv
RUN . venv/bin/activate && pip install -r /tmp/requirements.txt

ENV SMTP_USERNAME=$SMTP_USERNAME
ENV SMTP_PASSWORD=$SMTP_PASSWORD
ENV SELLER_CENTRAL_ACCESS_KEY_ID=$SELLER_CENTRAL_ACCESS_KEY_ID
ENV SELLER_CENTRAL_SECRET_KEY=$SELLER_CENTRAL_SECRET_KEY
ENV ACCOUNT_SID=$ACCOUNT_SID
ENV AUTH_TOKEN=$AUTH_TOKEN
ENV ANOTI_NUMBER=$ANOTI_NUMBER

RUN mkdir /root/app
ADD . /root/app/
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
