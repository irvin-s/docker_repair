#
# Based of abh1nav/cassandra with modifications to work in docker-compose
#
FROM abh1nav/opscenter

ADD . /modsrc

RUN \
    mkdir -p /opt/opscenter/conf/cluster; \
    cp /modsrc/cluster.conf /opt/opscenter/conf/cluster/;
    
