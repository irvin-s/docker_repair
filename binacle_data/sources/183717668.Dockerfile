# Builds a docker image that runs a Postgres server with the Bottled Water
# plugin installed. Requires that the binaries have been built first (see
# Dockerfile.build) and placed in the same directory as this Dockerfile.
#
# Usage:
#
#   (assuming the binaries have been placed into the build/ directory alongside
#   this Dockerfile)
#   docker build -f build/Dockerfile.postgres -t confluent/postgres-bw:0.1 build
#   docker run -d --name postgres confluent/postgres-bw:0.1
#
# To connect to the running container with psql:
#
#   docker run -it --rm --link postgres postgres:9.5 \
#     psql -h postgres -U postgres
#
# In the psql session, type the following to enable the plugin:
#
#   create extension bottledwater;

FROM postgres:9.5

RUN apt-get update && \
    apt-get install -y libjansson4

ADD bottledwater-ext.tar.gz /
ADD avro.tar.gz /
RUN cp /usr/local/lib/libavro.so.* /usr/lib/x86_64-linux-gnu/
COPY replication-config.sh /docker-entrypoint-initdb.d/replication-config.sh
