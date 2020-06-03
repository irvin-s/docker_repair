#
# Dockerfile that builds container with nodejs and Python
# When not using vagrant, run it manually with: docker build - < Dockerfile.nodejs
#


# Image: NodeJS & Python
#
# VERSION               0.0.1

FROM     ubuntu
MAINTAINER Jonas Colmsjö "jonas@gizur.com"

# sudo will complain about unknown host otherwise
RUN echo "127.0.0.1\t`hostname`" >> /etc/hosts

# make sure the package repository is up to date
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update -y


#
# Install some nice tools
#

RUN apt-get install -y git wget


#
# Install NodeJs
#

RUN apt-get update -y
RUN apt-get install -y python g++ make software-properties-common
RUN apt-get install -y --reinstall python-software-properties
RUN dpkg-reconfigure python-software-properties
RUN add-apt-repository -y ppa:chris-lea/node.js
RUN apt-get update -y
RUN apt-get install -y nodejs


#
# Install Python and virutalenv
#

RUN apt-get install -y build-essential python2.7-dev python-setuptools
RUN easy_install pip
RUN pip install virtualenv

# Install some dependensices (the OpenERP list)
RUN apt-get install -y python-dateutil python-feedparser python-ldap python-libxslt1 python-lxml python-mako python-openid python-psycopg2 python-reportlab python-simplejson python-tz python-vobject python-werkzeug python-yaml

RUN echo "Create a python env: virtualenv venv --distribute"
RUN echo "Then run: source venv/bin/activate"

