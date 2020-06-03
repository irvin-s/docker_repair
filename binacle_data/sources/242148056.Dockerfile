FROM  openjdk:8u131-jdk
ENV SCALA_VERSION 2.11.8
ENV SBT_VERSION 0.13.13
RUN touch /usr/lib/jvm/java-8-openjdk-amd64/release
RUN \
  curl -fsL https://downloads.typesafe.com/scala/$SCALA_VERSION/scala-$SCALA_VERSION.tgz | tar xfz - -C /root/ && \
  echo >> /root/.bashrc && \
  echo 'export PATH=~/scala-$SCALA_VERSION/bin:$PATH' >> /root/.bashrc
RUN \
  curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
  dpkg -i sbt-$SBT_VERSION.deb && \
  rm sbt-$SBT_VERSION.deb && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion
RUN echo Y | apt-get install gcc
WORKDIR /root/tipsy
ADD . /root/tipsy
RUN sbt compile
ENV LAB Lab11Q2
ENV CLUSTER 12
CMD sbt "run -le -cluster=$CLUSTER /root/tipsy/scripts/$LAB"
