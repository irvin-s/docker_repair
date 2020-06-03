FROM docker.io/centos:centos7
# FROM openshift/base-centos7
LABEL maintainer="tangfeixiong <tangfx128@gmail.com>" \
      project="https://github.com/tangfeixiong/go-to-kubernetes" \
      name="hadoop-operator" \
      annotation='{"example.com/hadoop-operator":"hdfs-springboot"}' \
      tag="centos java1.8 openjdk springboot"

ARG jarTgt
ARG javaUri
ARG javaOpt

COPY /maven/${jarTgt:-hdfs-springboot.jar} /hdfs-springboot.jar

ENV JAVA_OPTIONS="${javaOpt:-'-Xms128m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=256m'}" \
    SPRING_HADOOP_FSURI="hdfs://demo-hdfs-classic-0.demo-hdfs-classic.default.svc.cluster.local:9000" \
    GO_TO_KUBERNETES="hadoop-operator"

RUN set -x \
    && install_Pkgs=" \
        tar \
        unzip \
        bc \
        which \
        lsof \
        java-1.8.0-openjdk-headless \
    " \
    && yum install -y $install_Pkgs \
    && yum clean all -y \
    && echo

# This default user is created in the openshift/base-centos7 image
# USER 1001

CMD java -Djava.security.egd=file:/dev/./urandom $JAVA_OPTIONS -jar /hdfs-springboot.jar
