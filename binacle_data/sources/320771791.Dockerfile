FROM openjdk:8

RUN apt-get update \
  && apt-get upgrade \
  && apt-get install -y maven

RUN mkdir /qlri
WORKDIR /qlri

RUN git clone https://github.com/iotaledger/iota.lib.java
RUN cd iota.lib.java && mvn install

RUN git clone https://github.com/qubiclite/qlite.lib.java
RUN cd qlite.lib.java && mvn install

COPY . /qlri

RUN mvn versions:use-latest-versions -DallowSnapshots=true -DexcludeReactor=false

RUN mvn install

CMD java -jar qlri-0.5.0.jar -api
