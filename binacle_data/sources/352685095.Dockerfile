FROM mesosphere/mesos:0.24.1-0.2.35.ubuntu1404

ENV MESOS_NATIVE_JAVA_LIBRARY /usr/local/lib/libmesos.so

ENV SPARK_VERSION 1.5.1-bin-hadoop2.4

RUN apt-get update

RUN apt-get install -y curl && \
    curl -sf "http://d3kbcqa49mib13.cloudfront.net/spark-${SPARK_VERSION}.tgz" | tar zx -C /opt && \
    mv "/opt/spark-${SPARK_VERSION}" /opt/spark

ENV SPARK_HOME /opt/spark

# Define working directory.
WORKDIR /opt/spark

EXPOSE 4040
