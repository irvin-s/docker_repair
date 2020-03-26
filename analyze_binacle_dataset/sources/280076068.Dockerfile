FROM redis:4-alpine

ENV REDIS_PASSWORD redis

CMD ["sh", "-c", "exec redis-server --requirepass ${REDIS_PASSWORD}"]