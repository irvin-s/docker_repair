FROM alpine:3.6

ADD tmp/_output/bin/wildfly-operator /usr/local/bin/wildfly-operator
ADD config/standalone.xml /usr/local/wildfly-operator-config.xml

RUN adduser -D wildfly-operator
USER wildfly-operator
