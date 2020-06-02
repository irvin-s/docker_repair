FROM zookeeper:3.4

# note: zk default interval is 0 (none)
ENV ZOO_AUTOPURGE_SNAP_RETAIN_COUNT=3 \
    ZOO_AUTOPURGE_PURGE_INTERVAL=24

COPY zookeeper.docker-entrypoint.sh /docker-entrypoint.sh
RUN ["chmod", "+x", "/docker-entrypoint.sh"]