FROM confluentinc/cp-kafka-connect:4.0.0-3

MAINTAINER LoyaltyOne

RUN wget -P /usr/local/share/ https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.3.0/jmx_prometheus_javaagent-0.3.0.jar \
    && pip install --upgrade pip \
    && pip install awscli \
    && sed -i -e 's/-o errexit.*/-o errexit/g' -e 's/-o verbose.*//g' -e 's/-o xtrace.*//g' /etc/confluent/docker/launch \
    && sed -i -e 's/-o errexit.*/-o errexit/g' -e 's/-o verbose.*//g' -e 's/-o xtrace.*//g' /etc/confluent/docker/configure \
    && sed -i -e 's/-o errexit.*/-o errexit/g' -e 's/-o verbose.*//g' -e 's/-o xtrace.*//g' \
           -e 's/env  *[|]  *sort/env | sort | sed -e "s\/_PASSWORD=.*\/_PASSWORD=[hidden]\/g"/' etc/confluent/docker/run

COPY bootstrap setup-plugins.sh s3-cp.sh /usr/local/bin/
COPY kafka-connect-metrics.yml setup-plugins.sh s3-cp.sh /usr/local/share/

RUN setup-plugins.sh

ENTRYPOINT ["/usr/local/bin/bootstrap", "/usr/local/bin/s3-cp.sh", "/etc/confluent/docker/run"]