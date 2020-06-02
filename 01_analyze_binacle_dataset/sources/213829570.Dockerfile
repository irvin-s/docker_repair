# https://registry.hub.docker.com/_/redis/
FROM redis

ADD /images/redis/redis.conf /etc/redis/redis.conf