#
# This Dockerfile is automatically used with the vagrant script
# When not using vagratn, run it manually with: docker build - < Dockerfile
#


# Image: Openerp
#
# VERSION               0.0.1

FROM     ubuntu
MAINTAINER Jonas Colmsjö "jonas@gizur.com"

# sudo will complain about unknown host otherwise
RUN echo "127.0.0.1\t`hostname`" >> /etc/hosts

# make sure the package repository is up to date
#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get update -y


#
# Run a local Postgres database, create a Postgres user
#

RUN apt-get install -y postgresql libpq-dev

#RUN pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start
#RUN export PGDATA=/usr/local/var/postgres/
#RUN echo export PGDATA=/usr/local/var/postgres/ >> ~/.profile

# createuser --createdb --username postgres --no-createrole --pwprompt openerp
RUN su - postgres
RUN createuser --createdb --username postgres --no-createrole -s openerp
RUN exit

#
# Install Python and virutalenv
#

RUN apt-get install -y build-essential python2.7-dev python-setuptools git
RUN easy_install pip
RUN pip install virtualenv

#
# Install OpenERP dependencies
#

#RUN apt-get install -y python-dateutil python-feedparser python-gdata python-ldap \
#    python-libxslt1 python-lxml python-mako python-openid python-psycopg2 \
#    python-pybabel python-pychart python-pydot python-pyparsing python-reportlab \
#    python-simplejson python-tz python-vatnumber python-vobject python-webdav \
#    python-werkzeug python-xlwt python-yaml python-zsi


RUN apt-get install -y python-dateutil python-feedparser python-ldap \
    python-libxslt1 python-lxml python-mako python-openid python-psycopg2 \
    python-reportlab \
    python-simplejson python-tz python-vobject \
    python-werkzeug python-yaml

# Perhaps should add these
# libgdata-dev libxml2-dev libxslt-dev libldap2-dev

#
# Create a virtualenv for OpenERP and install stuff
#

RUN virtualenv venv --distribute
RUN source venv/bin/activate

RUN echo StrictHostKeyChecking=no >> /root/.ssh/config
RUN git clone https://github.com/colmsjo/openerp-env.git
RUN cd openerp-env && pip install -r requirements.txt

# Install Pychart manually, pip is broken
RUN cd PyChart && python setup.py install

# NOTE: Need to check if this is required/or even works!!
RUN apt-get install -y ghostscript


RUN cd openerp-7.0-20130603-231132 && python setup.py install
