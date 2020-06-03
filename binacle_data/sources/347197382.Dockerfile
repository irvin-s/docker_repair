FROM debian:jessie

MAINTAINER Ronan Guilloux <ronan.guilloux@gmail.com>

ENV PG_VERSION 9.4
RUN apt-get update
RUN apt-get -y install postgresql postgresql-client postgresql-contrib

# Allow remote connections:
RUN echo "listen_addresses='*'" >> /etc/postgresql/$PG_VERSION/main/postgresql.conf
RUN echo "host    all             all              0.0.0.0/0                  md5" >> /etc/postgresql/$PG_VERSION/main/pg_hba.conf

RUN service postgresql start && \
 su postgres sh -c "psql -c \"ALTER USER postgres PASSWORD 'postgres';\"";

# Expose VOLUMES to allow backup of config, logs and databases
VOLUME ["/var/log/postgresql", "/var/lib/postgresql", "/etc/postgresql"]

EXPOSE 5432
CMD ["su", "postgres", "-c", "/usr/lib/postgresql/$PG_VERSION/bin/postgres -D /var/lib/postgresql/$PG_VERSION/main/ -c config_file=/etc/postgresql/$PG_VERSION/main/postgresql.conf"]