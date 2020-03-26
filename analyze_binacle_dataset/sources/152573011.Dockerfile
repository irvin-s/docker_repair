# Storm rig for testing.
FROM piggybanksqueal/base
MAINTAINER James Lampton <jlampton@gmail.com>

# Configure zookeeper
#ADD zoo.cfg /opt/zookeeper/conf/ # Does nothing. zkCli.sh -server zookeeper:2181...

# Configure storm
RUN echo 'storm.zookeeper.servers: ["zookeeper"]' >> /opt/storm/conf/storm.yaml && \
    echo 'nimbus.host: "nimbus"' >> /opt/storm/conf/storm.yaml

# Configure hadoop
ADD hadoop/* /opt/hadoop/etc/hadoop/

ADD setup_entry.sh /

ENTRYPOINT ["/setup_entry.sh"]
