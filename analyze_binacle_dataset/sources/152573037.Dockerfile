# Zookeeper server for testing.
FROM piggybanksqueal/base
MAINTAINER James Lampton <jlampton@gmail.com>

# Configure ZK server
RUN sed -e 's,^#auto,auto,g' /opt/zookeeper/conf/zoo_sample.cfg > /opt/zookeeper/conf/zoo.cfg

EXPOSE 2181

ENTRYPOINT ["/opt/zookeeper/bin/zkServer.sh", "start-foreground"]
