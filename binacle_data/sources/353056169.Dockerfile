FROM rsoares/centos7-base

MAINTAINER Gustavo Luszczynski <gluszczy@redhat.com>, Rafael Soares (Tuelho) <rafaelcba@gmail.com>

RUN yum -y install java-1.8.0-openjdk-devel.x86_64;yum clean all

ENV JAVA_HOME /usr/lib/jvm/java

ENTRYPOINT ["java"]
CMD ["-version"]
