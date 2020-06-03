# Docker for SecurityMonkey
# Author : Nag
FROM ubuntu:14.04
MAINTAINER Nag <nagwww@gmail.com>

#For postgres installations
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 &&\
    echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list &&\
    apt-get update -y &&\
#    apt-get -y -q install python-software-properties software-properties-common postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3 &&\
#    apt-get -y -q install python-software-properties software-properties-common postgresql postgresql-client-9.3 postgresql-contrib &&\
#    apt-get install -y python-pip python-dev python-psycopg2 libpq-dev nginx supervisor git curl
    apt-get -y install python-pip python-dev python-psycopg2 postgresql postgresql-contrib libpq-dev nginx supervisor git libffi-dev curl apt-transport-https

#Run as postgres user
# Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3`` package when it was ``apt-get installed``
USER postgres

# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.

RUN /etc/init.d/postgresql start &&\
    psql --command "ALTER USER postgres with PASSWORD 'securitymonkeypassword'; " &&\
    psql --command "CREATE DATABASE \"secmonkey\";" &&\
    psql --command "CREATE ROLE \"securitymonkeyuser\" LOGIN PASSWORD 'securitymonkeypassword';" &&\
    psql --command "CREATE SCHEMA secmonkey ;" &&\
    psql --command "GRANT Usage, Create ON SCHEMA \"secmonkey\" TO \"securitymonkeyuser\"; " &&\
    psql --command "set timezone TO 'GMT';" &&\
    psql --command "select now();" &&\
    echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.6/main/pg_hba.conf &&\
    echo "listen_addresses='*'" >> /etc/postgresql/9.6/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432
EXPOSE 443

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

USER root
#RUN useradd -d /home/ubuntu -m -s /bin/bash ubuntu &&\
#    git clone https://github.com/Netflix/security_monkey.git /home/ubuntu/security_monkey &&\
#    cd /home/ubuntu/security_monkey && python setup.py install
RUN useradd -d /home/ubuntu -m -s /bin/bash ubuntu
RUN git clone --depth 1 --branch master https://github.com/Netflix/security_monkey.git /usr/local/src/security_monkey
RUN cd /usr/local/src/security_monkey && python setup.py install

ENV SECURITY_MONKEY_SETTINGS /usr/local/src/security_monkey/env-config/config-deploy.py

ADD securitymonkey.conf /etc/nginx/sites-available/
ADD securitymonkey.sh /usr/local/src/
ADD static.tar /usr/local/src/security_monkey/security_monkey/
CMD /usr/local/src/securitymonkey.sh
