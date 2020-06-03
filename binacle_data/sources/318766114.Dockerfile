FROM alpine:3.6

RUN adduser -D prometheus-replica-operator
USER prometheus-replica-operator

ADD tmp/_output/bin/prometheus-replica-operator /usr/local/bin/prometheus-replica-operator
