FROM centos:7
MAINTAINER Istvan Szukacs <leccine@gmail.com>
RUN curl -vjkL -H "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u31-b13/jdk-8u31-linux-x64.rpm > jdk-8u31-linux-x64.rpm
RUN rpm -i jdk-8u31-linux-x64.rpm
RUN curl -vjkL http://mirror.cogentco.com/pub/apache/kafka/0.8.2.0/kafka_2.10-0.8.2.0.tgz > kafka_2.10-0.8.2.0.tgz
RUN yum -y update; yum clean all; yum install tar -y;
RUN tar xzvf kafka_2.10-0.8.2.0.tgz 
EXPOSE 2181
ADD zookeeper.properties kafka_2.10-0.8.2.0/config/zookeeper.properties
RUN cat kafka_2.10-0.8.2.0/config/zookeeper.properties
CMD ["bash", "kafka_2.10-0.8.2.0/bin/zookeeper-server-start.sh", "kafka_2.10-0.8.2.0/config/zookeeper.properties"]
