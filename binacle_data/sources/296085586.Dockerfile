# The ucca Postgres Database container
# Complete with a good default for the data

FROM postgres:11

ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB ucca

COPY ucca.backup /
COPY initdb.sh /docker-entrypoint-initdb.d/initdb.sh
