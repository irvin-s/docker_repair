FROM phusion/baseimage:latest

MAINTAINER Markus Guenther <markus.guenther@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
ENV SCALA_VERSION 2.11
ENV KM_CONFIGFILE="/kafka-manager-1.3.1.8/conf/application.conf"
ENV KM_VERSION=1.3.1.8
ENV KM_REVISION=97329cc8bf462723232ee73dc6702c064b5908eb

# Install Oracle Java 8 and compile Yahoo Kafka Manager from source revision 97329cc8b
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer git unzip && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer && \
  mkdir -p /tmp && \
  cd /tmp && \
  git clone https://github.com/yahoo/kafka-manager && \
  cd /tmp/kafka-manager && \
  git checkout ${KM_REVISION} && \
  echo 'scalacOptions ++= Seq("-Xmax-classfile-name", "200")' >> build.sbt && \
  ./sbt clean dist && \
  unzip  -d / ./target/universal/kafka-manager-${KM_VERSION}.zip && \
  rm -fr /tmp/* /root/.sbt /root/.ivy2

ADD kafka-manager-start /usr/bin/kafka-manager-start

EXPOSE 9000

CMD ["/sbin/my_init", "kafka-manager-start"]
