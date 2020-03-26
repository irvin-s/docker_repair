#
# Based of abh1nav/cassandra with modifications to work in docker-compose
#
FROM abh1nav/cassandra

ADD . /modsrc

RUN \
    cp /modsrc/cassandra.yaml /opt/cassandra/conf/; \
    cp /modsrc/address.yaml  /opt/agent/conf/; \
    cp /modsrc/agent-run     /etc/service/agent/run; \
    cp /modsrc/cassandra-run /etc/service/cassandra/run;
    
