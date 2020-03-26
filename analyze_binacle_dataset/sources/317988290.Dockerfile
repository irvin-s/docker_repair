FROM ubuntu:16.04

RUN apt-get update -qq --fix-missing && \
    apt-get install -y wget

RUN  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc \
	| apt-key add -

RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" \
	>> /etc/apt/sources.list.d/postgresql.list

RUN apt-get update --fix-missing -qq && \ 
    apt-get install -y \
    	postgresql-9.5 \
    	postgresql-server-dev-9.5 \
    	postgresql-contrib-9.5 \
    	postgis \
    	postgresql-9.5-postgis-2.2 \
    	postgresql-9.5-postgis-scripts \
    	osm2pgsql \
    	dnsutils \
    	build-essential \
    	libpq-dev \
    	libstdc++-5-dev

ENV PGLOGS /var/log/postgres.log

RUN touch $PGLOGS
RUN chown postgres $PGLOGS

USER postgres

# These variables are for the build; changing them at runtime won't
# affect the container.
ENV PGVERS 9.5
ENV PGPATH /usr/lib/postgresql/$PGVERS/bin
ENV PGDATA /usr/local/data
ENV PGCONF /etc/postgresql/$PGVERS/main/postgresql.conf

# Configuration variables are meant to be set at runtime, and should
# only be used in the entrypoint.
ENV DB_PASS ""
ENV DB_NAME development
ENV DB_USER postgres

# Add the postgres binaries to our path so we can use the commands.
ENV PATH $PATH:$PGPATH

# Postgres will complain about these files not existing.
RUN mkdir /var/run/postgresql/$PGVERS-main.pg_stat_tmp/
RUN touch /var/run/postgresql/$PGVERS-main.pg_stat_tmp/global.tmp

HEALTHCHECK CMD pg_isready

USER root

ENV PATH_LIBPGOSM /usr/local/src/libpgosm
ADD ./src/libpgosm $PATH_LIBPGOSM

WORKDIR $PATH_LIBPGOSM
RUN make

WORKDIR /usr/local

ENV SCRIPT_PATH /usr/local/scripts

RUN apt-get install -y vim

ADD scripts/ ./scripts

WORKDIR ./scripts
USER root 
RUN chmod +x $SCRIPT_PATH/*.sh
RUN chown -R postgres $SCRIPT_PATH

RUN mkdir -p $PGDATA
RUN chown -R postgres $PGDATA

ENV PGBACKUP /mnt/pg_backup

RUN mkdir -p $PGBACKUP
RUN chown -R postgres $PGBACKUP

USER postgres

EXPOSE 5432

ENTRYPOINT $SCRIPT_PATH/docker-entrypoint.sh
