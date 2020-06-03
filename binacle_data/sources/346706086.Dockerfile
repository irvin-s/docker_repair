#
# Redis Dockerfile
#
# https://github.com/dockerfile/redis
#

# Pull base image.
#
# Just a stub. 

FROM 192.168.202.240:5000/lijiao/example-1-redis:2.8.19

ADD etc_redis_redis.conf /etc/redis/redis.conf

CMD ["redis-server", "/etc/redis/redis.conf"]
# Expose ports.
EXPOSE 6379
