FROM redis:4.0.6-alpine

RUN set -x \
   && apk add --update --no-cache ruby ruby-rdoc ruby-irb bash \
# Ruby client needed for redis-trib: https://rubygems.org/gems/redis
   && gem install redis

COPY redis-trib.rb /usr/local/bin/redis-trib

RUN mkdir -p /conf
COPY fix-ip.sh /conf/fix-ip.sh
COPY cluster.sh /conf/cluster.sh
# ENTRYPOINT ["/conf/fix-ip.sh"]

CMD ["/conf/fix-ip.sh", "redis-server"]
