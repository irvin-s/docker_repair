FROM postgres:9.6.6

ENV PGDATA=/usr/local/pgsql/data
ENV POSTGRES_PASSWORD=password1
ENV POSTGRES_USER=espadev
ENV POSTGRES_DB=espadev
ENV POSTGRES_INITDB_ARGS="-D $$PGDATA --locale en_US.UTF-8 -E UTF8 --auth-local=trust --auth-host=password"

COPY db_schema.sql /docker-entrypoint-initdb.d/01_schema.sql
COPY ordering_configuration.sql /docker-entrypoint-initdb.d/02_configdb.sql
COPY espadev_espa_unit_test_schema.sql /docker-entrypoint-initdb.d/03_unittest_schema.sql
COPY espadev_espa_unit_test_configuration.sql /docker-entrypoint-initdb.d/04_unittest_configdb.sql
