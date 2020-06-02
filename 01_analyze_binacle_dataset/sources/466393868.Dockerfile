FROM alpine:3.6

RUN adduser -D cassandra-operator
USER cassandra-operator

ADD tmp/_output/bin/cassandra-operator /usr/local/bin/cassandra-operator
