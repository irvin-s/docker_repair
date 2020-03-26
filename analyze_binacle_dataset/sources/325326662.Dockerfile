FROM redis:alpine

ENV CLIENTPORT 6379
ENV MASTERPORT 6379
ENV MASTERHOST 192.168.122.1
ENV CLIENTHOST 0.0.0.0
ENV APPENDFSYNC=everysec
ENV LISTENER_IP 192.168.122.1
ENV LISTENER_PORT 9080

ADD redis.conf /etc/redis.conf
RUN chown redis:redis /etc/redis.conf
RUN apk add curl
COPY post_db.sh /
RUN chmod +x /post_db.sh
EXPOSE $CLIENTPORT

ADD docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

CMD [ "redis-server","/etc/redis.conf" ]

