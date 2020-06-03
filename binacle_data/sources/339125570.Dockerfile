FROM timescale/timescaledb:latest-pg10

ADD replication.sh /docker-entrypoint-initdb.d/
