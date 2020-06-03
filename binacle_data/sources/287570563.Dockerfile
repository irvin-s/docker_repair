FROM orbs:base-server

ADD . /opt/orbs

RUN ./build-server.sh && yarn cache clean

HEALTHCHECK --interval=10s --timeout=10s --retries=3 \
    CMD curl -q http://localhost:8081/admin/startupCheck || exit 1

