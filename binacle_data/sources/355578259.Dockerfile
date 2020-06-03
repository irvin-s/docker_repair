FROM docker.io/centos:centos7
# FROM openshift/base-centos7
LABEL maintainer="tangfeixiong <tangfx128@gmail.com>" \
      project="https://github.com/tangfeixiong/go-to-kubernetes" \
      name="mooc-k8s" \
      namespace="stackdocker0x2Eio" \
      annotation='{"stackdocker.io/created-by":"n/a"}' \
      tag="centos java springboot tomcat jsp shiro restTemplate"

ARG jarTgt
ARG javaOpt

COPY ${jarTgt:-/target/web-server*.jar} /web-server.jar

ENV JAVA_OPTIONS="${javaOpt:-'-Xms128m -Xmx512m -XX:PermSize=128m -XX:MaxPermSize=256m'}" \
    APISERVER_ADDRESS="http://127.0.0.1:8090" \
    SERVER_PORT="8080"

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

CMD java -Djava.security.egd=file:/dev/./urandom $JAVA_OPTIONS -jar /web-server.jar