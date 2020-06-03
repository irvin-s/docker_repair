# Includes libmesos.so
FROM mesosphere/mesos:1.3.0

RUN apt-get update && \
    apt-get install -y \
            runit \
            curl \
            krb5-user \
            software-properties-common

RUN add-apt-repository --yes ppa:openjdk-r/ppa

RUN apt-get update && \
    apt-get install --yes \
    openjdk-8-jdk\
    wget \
    tar

# The base image contains java 8, but it has no environment variables set for it.
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre

RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java

ENV MESOS_NATIVE_JAVA_LIBRARY /usr/lib/libmesos.so

ENV HADOOP_CONF_DIR /etc/hadoop/conf/

ADD runit/service /var/lib/runit/service

ADD runit/init.sh /sbin/init.sh

RUN chmod +x /sbin/init.sh

RUN ln -s /var/lib/runit/service/flink /etc/service/flink

RUN chmod -R ugo+rw /etc/service

RUN chmod -R ugo+rw /var/lib/

RUN chmod -R ugo+rw /var/run/

RUN chmod -R ugo+rw /var/log/

WORKDIR /

# Copy custom build to image.
COPY flink/flink-dist/target/flink-1.4.2-bin/ .

# Copy base Flink configuration to image.
COPY conf/ flink-1.4.2/conf/

WORKDIR flink-1.4.2

ENV FLINK_HOME /flink-1.4.2
ENV FLINK_CONF_DIR /flink-1.4.2/conf
