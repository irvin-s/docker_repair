FROM ubuntu:16.04

# utilities
RUN apt-get -y update; apt-get -y install apt-transport-https bc curl vim apt-utils software-properties-common git zlib1g-dev uuid-dev libmnl-dev gcc make git autoconf autoconf-archive autogen automake pkg-config curl

# env variables
ENV ADAMPRO_HOME /adampro
ENV ADAMPRO_CODE ${ADAMPRO_HOME}/code
ENV ADAMPRO_DATA ${ADAMPRO_HOME}/data

# updating JDK to version 8
RUN apt-get update; \
    apt-get -y install openjdk-8-jdk openjdk-8-jre-headless

# updating scala to 2.11
RUN mkdir -p /usr/lib/scala-2.11.8 && curl 'http://www.scala-lang.org/files/archive/scala-2.11.8.tgz' | tar -xz -C /usr/lib/; \
    ln -s /usr/lib/scala-2.11.8 /usr/lib/scala
ENV SCALA_HOME /usr/lib/scala
ENV PATH "$PATH:$SCALA_HOME/bin"

# sbt
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list; \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 && apt-get update; \
    apt-get -y install sbt; \
    apt-get -y remove openjdk-9-*

# spark
RUN curl http://mirror.easyname.ch/apache/spark/spark-2.4.0/spark-2.4.0-bin-hadoop2.7.tgz | tar -xz -C /usr/lib/; \
    cd /usr/lib && ln -s spark-2.2.0-bin-hadoop2.7 spark
ENV SPARK_HOME /usr/lib/spark

# netdata
ARG NETDATA_HOME=/usr/lib/netdata/
RUN git clone https://github.com/netdata/netdata.git --depth=1 $NETDATA_HOME && cd $NETDATA_HOME && ./netdata-installer.sh --dont-start-it --dont-wait

# ADAMpro
RUN mkdir -p ${ADAMPRO_HOME}; chmod 777 ${ADAMPRO_HOME}

ENV ADAMPRO_GIT "https://github.com/vitrivr/ADAMpro.git"
ENV ADAMPRO_BRANCH "master"

# careful: the next step is potentially cached by Docker!
RUN git clone -b $ADAMPRO_BRANCH $ADAMPRO_GIT --recursive $ADAMPRO_CODE

RUN cd $ADAMPRO_CODE && sbt proto && sbt assembly && sbt web/assembly; \
    cp $ADAMPRO_CODE/conf/log4j.xml ${ADAMPRO_HOME}/log4j.xml; \
    cp $ADAMPRO_CODE/conf/log4j.properties ${ADAMPRO_HOME}/log4j.properties; \
    cp $ADAMPRO_CODE/target/scala-2.11/ADAMpro-assembly-0.1.0.jar ${ADAMPRO_HOME}/ADAMpro-assembly-0.1.0.jar && cp $ADAMPRO_CODE/web/target/scala-2.11/ADAMpro-web-assembly-0.1.0.jar ${ADAMPRO_HOME}/ADAMpro-web-assembly-0.1.0.jar
COPY update.sh ${ADAMPRO_HOME}/update.sh
RUN chmod 700 ${ADAMPRO_HOME}/update.sh

# port for spark UI
EXPOSE 4040
# port for grpc
EXPOSE 5890
# port for ADAMpro web UI
EXPOSE 9099
# port for netdata
EXPOSE 19999

# bootstrap
ENV ADAMPRO_EXECUTOR_MEMORY 2g
ENV ADAMPRO_DRIVER_MEMORY 2g
ENV ADAMPRO_MASTER local[4]

COPY adampro.conf ${ADAMPRO_HOME}/adampro.conf
RUN chown root.root ${ADAMPRO_HOME}/adampro.conf; chmod 700 ${ADAMPRO_HOME}/adampro.conf
COPY wait-for-it.sh ${ADAMPRO_HOME}/wait-for-it.sh
RUN chown root.root ${ADAMPRO_HOME}/wait-for-it.sh; chmod 700 ${ADAMPRO_HOME}/wait-for-it.sh
COPY bootstrap.sh ${ADAMPRO_HOME}/bootstrap.sh
RUN chown root.root ${ADAMPRO_HOME}/bootstrap.sh; chmod 700 ${ADAMPRO_HOME}/bootstrap.sh

ENTRYPOINT ["/adampro/bootstrap.sh"]

# per default, the node is started as master
CMD ["--masternode"]