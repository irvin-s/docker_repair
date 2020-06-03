FROM mysql:8.0

COPY db/schema.sql /docker-entrypoint-initdb.d/001-schema.sql
COPY db/sample.sql /docker-entrypoint-initdb.d/002-sample.sql
