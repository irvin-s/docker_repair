#
# Dockerfile for postgres: 9.3-sde
#

FROM postgres:9.3

MAINTAINER xzdbd <xzdbd@sina.com>

ENV LD_LIBRARY_PATH /usr/lib/postgresql/9.3/lib

COPY lib/st_geometry.so /usr/lib/postgresql/9.3/lib/st_geometry.so

COPY dump/postgres-dump /postgres-dump

COPY restore-sdedb.sh /docker-entrypoint-initdb.d/restore-sdedb.sh




