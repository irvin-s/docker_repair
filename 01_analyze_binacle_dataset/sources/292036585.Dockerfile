FROM ubuntu:trusty
MAINTAINER Ken Jenney <mastermindg@gmail.com>

ARG TRAC_ADMIN_NAME=trac_admin
ENV TRAC_ADMIN_NAME ${TRAC_ADMIN_NAME}
ARG TRAC_ADMIN_PASS=passw0rd
ENV TRAC_ADMIN_PASS ${TRAC_ADMIN_PASS}
ARG TRAC_PROJECT_NAME=trac_project
ENV TRAC_PROJECT_NAME ${TRAC_PROJECT_NAME}
ARG TRAC_DIR=/trac 
ENV TRAC_DIR ${TRAC_DIR}
ARG TRAC_INI=$TRAC_DIR/conf/trac.inia
ENV TRAC_INI ${TRAC_INI}
ARG DB_LINK=sqlite:db/trac.db
ENV DB_LINK ${DB_LINK}

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y pwgen git-core trac \ 
    trac-git trac-accountmanager trac-customfieldadmin trac-xmlrpc \ 
    trac-wikiprint trac-wysiwyg trac-mastertickets trac-tags \
    trac-diavisview trac-announcer trac-graphviz python-flup \
    supervisor apache2-utils apache2 libapache2-mod-wsgi python-pip \
    python-mysqldb libpq-dev python-dev && \
    apt-get -y clean && rm -rf /var/lib/apt/lists/*

RUN pip install psycopg2  # Python bindings for Postgresql
RUN rm /etc/apache2/sites-enabled/000-default.conf
ADD supervisord-apache2.conf /etc/supervisor/conf.d/supervisord-apache2.conf
ADD apache_start.sh /
ADD trac_logo.png /var/www/trac_logo.png
ADD run.sh /
ADD setup_trac.sh /
RUN chmod 755 /*.sh

EXPOSE 80

CMD /run.sh
