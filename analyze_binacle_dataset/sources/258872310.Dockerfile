# earthquake demo for reproduction of ZOOKEEPER-1797 ("PurgeTxnLog may delete data logs during roll")

FROM java:7
MAINTAINER Akihiro Suda <suda.akihiro@lab.ntt.co.jp>

# Mar 30, 2015
ENV EARTHQUAKE_GIT_COMMIT ca91befb0556bddbf8229ef9b6650ec94cf79471
# Apr 14, 2015 (Forked from ZooKeeper 3.4.5 (Nov 19, 2012))
ENV ZOOKEEPER_GIT_COMMIT 4d08af6da87eac3b565d599b0d24683e2e734827

WORKDIR /

RUN apt-get update && \
  apt-get install -y ant protobuf-compiler golang golang-goprotobuf-dev

RUN git clone https://github.com/osrg/earthquake.git && \
  ( cd earthquake && \
    git checkout ${EARTHQUAKE_GIT_COMMIT} && \
    ./build )

ENV JAVA_TOOL_OPTIONS -Dfile.encoding=UTF8
RUN git clone -b zookeeper-1797 https://github.com/osrg/zookeeper.git && \
  ( cd zookeeper && \
    git checkout ${ZOOKEEPER_GIT_COMMIT} && \
    cp -f earthquake/zookeeper-1797/lib/* src/java/lib && \
    cp -f earthquake/zookeeper-1797/aj/* src/java/main/org/apache/zookeeper/server && \
    cp -f conf/zoo_sample.cfg conf/zoo.cfg && \
    echo snapCount=30 >> conf/zoo.cfg && \
    ant clean jar-ajc )

# just for the sake of ease
RUN apt-get install -y less lv vim

ENV EQ_DIRECT_MODE 1
ENV EQ_ENV_PROCESS_ID zookeeper-1797
ADD demo.sh /
CMD ["/demo.sh"]
