ARG PGVER
FROM postgres:${PGVER}

ARG PGVER
ARG PGHOME=/var/lib/postgresql
ENV PGDATA=/var/lib/postgresql/test
ENV PGVER=${PGVER}
ENV HOME=${PGHOME}

SHELL ["/bin/bash", "-c"]

# app and app tests
USER root

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ssh pbzip2 rsync file gosu \
        bats wget ca-certificates \
        less vim tree \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/*

RUN chmod +s /usr/sbin/gosu \
    && usermod --home ${PGHOME} postgres \
    && echo -e '\nSSHD_OPTS=-De' >> /etc/default/ssh \
    && install -v -o postgres -g postgres -d \
        /archive \
        /archive/wals \
        /archive/logs.complete \
        /lib/init/rw/pg_recv_sb \
    && install -v -o postgres -g postgres \
        /dev/null /etc/postgresql-common/compress.mime.mgc \
    && echo -e 'remote_cmd=/app/archive_remote_cmd_2\n' >> /etc/default/archive_cmd \
    && echo -e 'remote_cmd=/app/archive_remote_cmd_2\n' >> /etc/default/archive_remote_cmd

# switch to app system user and setup db tests
USER postgres

RUN initdb \
    && echo 'host all all 0.0.0.0/0 trust'              >> ${PGDATA}/pg_hba.conf \
    && echo 'host replication postgres 0.0.0.0/0 trust' >> ${PGDATA}/pg_hba.conf \
    && echo 'wal_keep_segments=10' >> ${PGDATA}/postgresql.auto.conf \
    && echo 'wal_level=replica'    >> ${PGDATA}/postgresql.auto.conf \
    && echo 'max_wal_senders=5'    >> ${PGDATA}/postgresql.auto.conf \
    && echo 'archive_mode=on'      >> ${PGDATA}/postgresql.auto.conf \
    && echo 'archive_command='\''test ! -f /archive/logs.complete/%f && cp %p /archive/logs.complete/%f'\' >> ${PGDATA}/postgresql.auto.conf \
    && ssh-keygen -N '' -f ~/.ssh/id_rsa < /dev/null \
    && cp ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
# ~/.ssh/known_hosts in docker-entrypoint.sh

RUN pg_ctl -w start \
    && createdb test \
    && psql -X -At -d test -c " \
        /* generate some WALs for tests */ \
        create table payload(a,b,c,d,e) as select v,v,v,v,v from (select 'this is text for fill space ' || generate_series(1, 500000) v) _; \
        drop table payload; \
        select pg_xlogfile_name(pg_current_xlog_insert_location()); \
    " \
    && pg_ctl -w stop -m fast \
    && cp -ar ${PGDATA}/pg_xlog /tmp

RUN cd /tmp \
    && wget -O compress.mime https://raw.githubusercontent.com/file/file/master/magic/Magdir/compress \
    && file -m compress.mime -C \
    && cp compress.mime.mgc /etc/postgresql-common/compress.mime.mgc \
    && rm compress.mime.mgc

WORKDIR /app

ENTRYPOINT ["/app/tests/docker-entrypoint.sh"]
