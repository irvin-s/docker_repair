FROM redis

MAINTAINER danigosa <danigosa@gmail.com>

EXPOSE 26379
ADD sentinel.conf /etc/redis/sentinel.conf
RUN chown redis:redis /etc/redis/sentinel.conf
ENV SENTINEL_QUORUM 2
ENV SENTINEL_DOWN_AFTER 5000
ENV SENTINEL_FAILOVER 180000
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]