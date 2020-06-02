FROM ubuntu:14.04

MAINTAINER Tim Co <tim@pinn.ai>

ENV DEBIAN_FRONTEND noninteractive

#    Application container combining Flask and uwsgi
#
#    A virtual environment is setup in order to separate 
#    system packages neatly away from application based tools.

RUN apt-get update && apt-get install -qqy --no-install-recommends \
    build-essential \
    curl \
    git \
    python-dev \
    zip \
    vim \
    python-pip \
    wget \
    sed \
    uwsgi-plugin-python \
    rabbitmq-server \
    supervisor \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Working directory
WORKDIR /var/www/app

# Application requirements and configuration
COPY requirements.txt .

# virtualenv
RUN pip install virtualenv && \
    virtualenv -p python2.7 .venv

RUN . .venv/bin/activate                             && \ 
    pip install -r requirements.txt

# Supervisord
COPY supervisord.conf /etc/supervisor/conf.d/app.conf
RUN mkdir -p /var/log/supervisord

# Uwsgi
COPY uwsgi.ini .
RUN mkdir -p /var/log/uwsgi
RUN mkdir -p /var/run/uwsgi
