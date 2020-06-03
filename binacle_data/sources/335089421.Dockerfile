FROM confluentinc/cp-kafka:4.0.0-3

MAINTAINER LoyaltyOne

# The sed commands turn off verbose logging so passwords get hidden
RUN wget -P /usr/local/share/ https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.3.0/jmx_prometheus_javaagent-0.3.0.jar \
    && pip install --upgrade pip \
    && pip install awscli \
    && sed -i -e 's/-o errexit.*/-o errexit/g' -e 's/-o verbose.*//g' -e 's/-o xtrace.*//g' /etc/confluent/docker/launch \
    && sed -i -e 's/-o errexit.*/-o errexit/g' -e 's/-o verbose.*//g' -e 's/-o xtrace.*//g' /etc/confluent/docker/configure \
    && sed -i -e 's/-o errexit.*/-o errexit/g' -e 's/-o verbose.*//g' -e 's/-o xtrace.*//g' \
           -e 's/env  *[|]  *sort/env | sort | sed -e "s\/_PASSWORD=.*\/_PASSWORD=[hidden]\/g"/' etc/confluent/docker/run

COPY bootstrap /usr/local/bin/
COPY kafka-metrics.yml /usr/local/share/

ENTRYPOINT ["/usr/local/bin/bootstrap"]
CMD ["/etc/confluent/docker/run"]