#
# PostgreSQL Dockerfile on CentOS 7
#

# Build:
# docker build -t zokeber/postgresql:latest .
#
# Create:
# docker create -it -p 5432:5432 --name postgresql94 zokeber/postgresql
#
# Start:
# docker start postgresql94
#
# Connect with postgresql client
# docker exec -it postgresql94 psql
#
# Connect bash
# docker exec -it postgresql94 bash


# Pull base image
FROM zokeber/centos:latest

# Maintener
MAINTAINER Daniel Lopez Monagas <zokeber@gmail.com>

# Postgresql version
ENV PG_VERSION 9.4
ENV PGVERSION 94

# Set the environment variables
ENV HOME /var/lib/pgsql
ENV PGDATA /var/lib/pgsql/9.4/data

# Install postgresql and run InitDB
RUN rpm -vih https://download.postgresql.org/pub/repos/yum/$PG_VERSION/redhat/rhel-7-x86_64/pgdg-centos$PGVERSION-$PG_VERSION-2.noarch.rpm && \
    yum update -y && \
    yum install -y sudo \
    pwgen \
    postgresql$PGVERSION \
    postgresql$PGVERSION-server \
    postgresql$PGVERSION-contrib && \
    yum clean all

# Copy
COPY data/postgresql-setup /usr/pgsql-$PG_VERSION/bin/postgresql$PGVERSION-setup

# Working directory
WORKDIR /var/lib/pgsql

# Run initdb
RUN /usr/pgsql-$PG_VERSION/bin/postgresql$PGVERSION-setup initdb

# Copy config file
COPY data/postgresql.conf /var/lib/pgsql/$PG_VERSION/data/postgresql.conf
COPY data/pg_hba.conf /var/lib/pgsql/$PG_VERSION/data/pg_hba.conf
COPY data/postgresql.sh /usr/local/bin/postgresql.sh

# Change own user
RUN chown -R postgres:postgres /var/lib/pgsql/$PG_VERSION/data/* && \
    usermod -G wheel postgres && \
    sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers && \
    chmod +x /usr/local/bin/postgresql.sh

# Set volume
VOLUME ["/var/lib/pgsql"]

# Set username
USER postgres

# Run PostgreSQL Server
CMD ["/bin/bash", "/usr/local/bin/postgresql.sh"]

# Expose ports.
EXPOSE 5432
