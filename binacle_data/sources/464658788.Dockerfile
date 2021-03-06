FROM openjdk:8-alpine
MAINTAINER gang.tao@outlook.com

# Default Args
ARG APACHE_MIRROR_SERVER=http://www-us.apache.org
ARG SPARK_VERSION=2.3.1
ARG HADOOP_VERSION=2.7
ENV GLIBC_VERSION=2.26-r0
RUN apk update && \
    apk add bash curl git python3 wget vim openssl ca-certificates snappy && \
    mkdir -p /etc/BUILDS/ && \
    printf "Build of nimmis/alpine-glibc:3.5, date: %s\n"  `date -u +"%Y-%m-%dT%H:%M:%SZ"` > /etc/BUILDS/alpine-glibc && \
    # download packages for glibc, see https://github.com/sgerrand/alpine-pkg-glibc for more info
    curl -L -o glibc-${GLIBC_VERSION}.apk \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk" && \
    curl -L -o glibc-bin-${GLIBC_VERSION}.apk \
      "https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk" && \
    # install glibc to support snappy
    apk add --allow-untrusted glibc-${GLIBC_VERSION}.apk glibc-bin-${GLIBC_VERSION}.apk && \
    rm -rf /var/cache/apk/*


RUN mkdir -p /opt \
    && wget -q -O - ${APACHE_MIRROR_SERVER}/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz | tar -xzf - -C /opt \
    && mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} /opt/spark
ENV SPARK_HOME /opt/spark
ENV PATH=$PATH:${SPARK_HOME}/sbin:${SPARK_HOME}/bin
WORKDIR $SPARK_HOME