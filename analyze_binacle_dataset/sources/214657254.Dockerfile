FROM centos:6.6
MAINTAINER Nicola Ferraro <nibbio84@gmail.com>

RUN yum install -y git

RUN curl https://bintray.com/sbt/rpm/rpm | tee /etc/yum.repos.d/bintray-sbt-rpm.repo
RUN yum install -y sbt


RUN mkdir /spark
WORKDIR /spark

RUN git clone https://github.com/spark-jobserver/spark-jobserver.git

WORKDIR /spark/spark-jobserver/

RUN export VER=`sbt version | tail -1 | cut -f2`

# Pre-fetch dependencies and kill
RUN sbt reStart

EXPOSE 8090

ADD ./start-jobserver.sh ./

CMD ./start-jobserver.sh