FROM orientdb:3.0.0m2-spatial

COPY ./config/hazelcast.xml /orientdb/config/
COPY ./lib/* /orientdb/lib/
