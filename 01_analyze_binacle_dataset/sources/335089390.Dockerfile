ARG JMXTRANS_VERSION
FROM jmxtrans/jmxtrans

MAINTAINER LoyaltyOne

# JMXTRANS_ENV=aws|local
ENV JMXTRANS_ENV=local

# JMXTRANS_HOSTS=type1#host1:port1,host2:port2,host3:port3..|type2#host4:port4,host5:port5,...|...
# type=zookeeper|kafka|schema-registry|kafka-connect|kafka-rest
ENV JMXTRANS_HOSTS=zookeeper#localhost:8989

# JMXTRANS_ALIASES=alias1,alias2,alias3|alias4,alias5,alias6|...
# This is useful if you are using 'localhost' for hostname but want to alias it.
# These should correspond exactly with JMX_HOSTS. If it turns up empty;
# the hostname from JMXTRANS_HOST will be used.
ENV JMXTRANS_ALIASES=zookeeper

# Copy configuration templates and entrypoint script
COPY config/*.json /usr/local/share/config/
COPY bootstrap /usr/local/bin/

# Install jq and load a JMX client
RUN apk update && \
    apk add jq && \
    wget -P /usr/local/share http://crawler.archive.org/cmdline-jmxclient/cmdline-jmxclient-0.10.3.jar

# Execute our bootstrap before jmxtrans' entry point before starting the container.
ENTRYPOINT ["/usr/local/bin/bootstrap", "/docker-entrypoint.sh"]
CMD ["start-with-jmx"]