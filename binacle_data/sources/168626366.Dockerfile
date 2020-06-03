#
#   Author: Rohith (gambol99@gmail.com)
#   Date: 2014-10-21 10:27:08 +0100 (Tue, 21 Oct 2014)
#
#  vim:ts=2:sw=2:et
#
FROM redis-base
MAINTAINER <gambol99@gmail.com>

ADD config/confd/conf.d/redis.conf.toml /etc/confd/conf.d/redis.conf.toml
ADD config/confd/templates/

ENV APP redis

