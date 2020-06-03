#
FROM centos_base
MAINTAINER xiaocai <miss339742811@163.com>

#install redis
ADD ./package/redis-2.8.19.tar.gz /data/install
ADD ./install_redis.sh /data/install/install_redis.sh

RUN chmod 755 /data/install/install_redis.sh
RUN /data/install/install_redis.sh

EXPOSE 6379