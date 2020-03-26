FROM python:2.7
MAINTAINER Lu Pa <admin@tedic.org>

ENV DEBIAN_FRONTEND noninteractive
ENV CODE /usr/src/libreqda

RUN apt-get update \
	&& apt-get -y dist-upgrade

#Creo dos carpetas libreqda una dentro de la otra
RUN mkdir -p $CODE/libreqda

COPY manage.py $CODE
COPY requirements.txt $CODE 
COPY libreqda $CODE/libreqda

WORKDIR $CODE

#FIXME work in progress
