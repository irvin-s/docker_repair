FROM redis:3.2.7-alpine

COPY ./redis.conf /etc/redis.conf

CMD [ "redis-server", "/etc/redis.conf" ]