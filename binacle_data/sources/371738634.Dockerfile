# Golismero Docker Container
#
#
# GoLismero is an open source framework for security testing

FROM python:2.7.11

MAINTAINER Jason Soto "www.jasonsoto.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update; apt-get -y install git \
    perl \
    nmap \
    sslscan \
    apache2

# Clone Project Repo

RUN git clone https://github.com/golismero/golismero /opt/golismero

WORKDIR /opt/golismero

RUN pip install -r requirements.txt

RUN pip install -r requirements_unix.txt

RUN ln -s /opt/golismero/golismero.py /usr/bin/golismero

ENTRYPOINT ["golismero"]
