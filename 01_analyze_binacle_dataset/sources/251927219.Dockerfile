FROM parrotstream/hadoop:3.0.0-cdh6.0.0

MAINTAINER Matteo Capitanio <matteo.capitanio@gmail.com>

USER root

ENV HIVE_VER 3.1.0
ENV TEZ_VER 0.9.1

ENV HIVE_HOME /opt/hive
ENV HIVE_CONF_DIR $HIVE_HOME/conf
ENV HADOOP_HOME /opt/hadoop
ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop
ENV HCAT_LOG_DIR /opt/hive/logs
ENV HCAT_PID_DIR /opt/hive/logs
ENV WEBHCAT_LOG_DIR /opt/hive/logs
ENV WEBHCAT_PID_DIR /opt/hive/logs

ENV PATH $HIVE_HOME/bin:$PATH

# Install needed packages
RUN yum clean all; \
    yum update -y; \
    yum install -y postgresql; \
    yum clean all

WORKDIR /opt/docker

# Apache Hive
RUN wget http://it.apache.contactlab.it/hive/hive-$HIVE_VER/apache-hive-$HIVE_VER-bin.tar.gz
RUN tar -xvf apache-hive-$HIVE_VER-bin.tar.gz -C ..; \
    mv ../apache-hive-$HIVE_VER-bin $HIVE_HOME
RUN wget https://jdbc.postgresql.org/download/postgresql-42.2.5.jar -O $HIVE_HOME/lib/postgresql-42.2.5.jar
RUN wget http://it.apache.contactlab.it/tez/0.9.1/apache-tez-0.9.1-bin.tar.gz; \
    tar -xvf apache-tez-0.9.1-bin.tar.gz
RUN cp apache-tez-0.9.1-bin/tez*.jar $HIVE_HOME/lib/; \
    rm -rf apache-tez-0.9.1-bin; \
    rm -f apache-tez-0.9.1-bin.tar.gz
COPY hive/ $HIVE_HOME/
COPY ./etc /etc

RUN chmod +x $HIVE_HOME/bin/*.sh

RUN useradd -p $(echo "hive" | openssl passwd -1 -stdin) hive; \
    usermod -a -G hdfs hive;

EXPOSE 9083 10000 10002 50111

VOLUME ["/opt/hive/conf", "/opt/hive/logs"]

ENTRYPOINT ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
