##
# NodeJS MongoDB Redis
#
# This creates an image which contains an environment for NodeJS app ecosystem
# - Node.js 0.10.23
# - MongoDB 2.4.8
# - Redis 2.4.15
##

FROM truongsinh/nodejs

MAINTAINER TruongSinh Tran-Nguyen <i@truongsinh.pro>

# Fix upstart under a virtual host https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl \
 && ln -s /bin/true /sbin/initctl

# Configure Package Management System (APT) & install MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 \
 && echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | tee /etc/apt/sources.list.d/mongodb.list \
 && apt-get update \
 && apt-get install -y mongodb-10gen

# Redis server
RUN apt-get install -y redis-server

# Start MongoDB
CMD mongod --fork -f /etc/mongodb.conf \
 && redis-server /etc/redis/redis.conf \
 && bash
