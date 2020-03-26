# Builds a docker image for the Bottled Water client.
# Expects links to "postgres", "kafka" and "schema-registry" containers.
#
# Usage:
#
#   (assuming the binaries have been placed into the build/ directory alongside
#   this Dockerfile)
#   docker build -f build/Dockerfile.client -t confluent/bottledwater:0.1 build
#   docker run -d --name bottledwater --link postgres:postgres --link kafka:kafka --link schema-registry:schema-registry confluent/bottledwater:0.1

FROM postgres:9.5

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        libcurl3 libjansson4 libpq5 valgrind

ADD avro.tar.gz /
ADD librdkafka.tar.gz /
ADD bottledwater-bin.tar.gz /

COPY bottledwater-docker-wrapper.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/bottledwater-docker-wrapper.sh

RUN cp /usr/local/lib/librdkafka.so.* /usr/lib/x86_64-linux-gnu && \
    cp /usr/local/lib/libavro.so.* /usr/lib/x86_64-linux-gnu

ENTRYPOINT ["/usr/local/bin/bottledwater-docker-wrapper.sh"]
CMD ["--output-format=json", "--allow-unkeyed"]
