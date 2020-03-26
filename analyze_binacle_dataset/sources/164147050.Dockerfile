FROM orientdb:2.2.33-spatial

COPY ./config/hazelcast.xml /orientdb/config/
COPY ./lib/* /orientdb/lib/
