# Elasticsearch
# docker pull barnybug/redis
#
# VERSION               0.0.1
FROM ubuntu:12.04
MAINTAINER Barnaby Gray <barnaby@pickle.me.uk>

ADD redis-server /usr/bin/
ADD redis-cli /usr/bin/

EXPOSE 6379
CMD ["/usr/bin/redis-server"]
