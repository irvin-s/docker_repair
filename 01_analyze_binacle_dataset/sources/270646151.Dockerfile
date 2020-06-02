FROM redis:4.0.8

# Change Timezone
ARG TIME_ZONE=UTC
ENV TIME_ZONE ${TIME_ZONE}
RUN ln -snf /usr/share/zoneinfo/$TIME_ZONE /etc/localtime && echo $TIME_ZONE > /etc/timezone

CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]