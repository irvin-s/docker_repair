FROM ubuntu:16.04

MAINTAINER fjerlv@cs.au.dk

RUN apt-get update

RUN apt-get install -y python3 python3-pip libpq-dev curl

RUN pip3 install --upgrade pip

COPY requirements.txt /root/deathquake/requirements.txt
RUN pip3 install -r /root/deathquake/requirements.txt

COPY deathquake/ /root/deathquake/deathquake/
COPY stats/ /root/deathquake/stats/
COPY manage.py /root/deathquake/manage.py

ENV DJANGO_SETTINGS_MODULE="deathquake.settings.docker"

WORKDIR /root/deathquake/
