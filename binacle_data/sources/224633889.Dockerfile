FROM centos7/jdk7
MAINTAINER pro zpang@dataman-inc.com

#modify localtime
RUN cp -f /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#install base
RUN  yum install -y \
         epel-release \
         wget \
	 curl && \
     yum clean all

#kafuka env
ENV KAFKA_VERSION="0.8.2.2" SCALA_VERSION="2.11"
ENV P_NAME kafka_${SCALA_VERSION}-${KAFKA_VERSION}
ENV KAFKA_INSTALL_HOME /opt/${P_NAME}
ENV KAFKA_HOME /usr/local/kafka

#install kafka
RUN wget -q http://www.eu.apache.org/dist/kafka/${KAFKA_VERSION}/${P_NAME}.tgz -O "/tmp/${P_NAME}.tgz" && \
    tar xf /tmp/${P_NAME}.tgz -C /opt/ && \
    rm -f /tmp/${P_NAME}.tgz && \
    /bin/chmod -R 775 $KAFKA_INSTALL_HOME && \
    /bin/ln -s $KAFKA_INSTALL_HOME $KAFKA_HOME

# create dir
RUN mkdir -p /data/run && \
    mkdir -p /data/logs

# remote script
COPY dataman.properties.template /usr/local/kafka/config/dataman.properties.template
COPY kafka-marathon-bootstrap.sh /data/run/kafka-marathon-bootstrap.sh
RUN chmod 755 /data/run/kafka-marathon-bootstrap.sh
ENTRYPOINT ["/data/run/kafka-marathon-bootstrap.sh"]
