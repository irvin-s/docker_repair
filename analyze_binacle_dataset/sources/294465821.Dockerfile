# To use directly, run: docker build --build-arg package=<pkg>.xenial.deb -t <tag> -f Dockerfile-xenial
FROM ubuntu:xenial

EXPOSE 8000

ARG version=0.0.21-1
ARG package=https://storage.googleapis.com/stackdriver-container-alpha/deb/xenial/stackdriver-metadata_${version}.xenial.deb
ADD ${package} /stackdriver-metadata.deb
RUN apt-get update \
    && (dpkg -i /stackdriver-metadata.deb || true) \
    && apt-get install -f -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /stackdriver-metadata.deb
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/opt/stackdriver/metadata/sbin/metadatad"]
