FROM ubuntu:16.04
MAINTAINER Grant Heffernan <grant@mapzen.com>

# env
ENV DEBIAN_FRONTEND noninteractive

ENV VALHALLA_VERSION "2.4.5"

ENV MATCHER_DATA_DIR ${MATCHER_DATA_DIR:-"/data/valhalla"}
ENV MATCHER_CONF_FILE ${MATCHER_CONF_FILE:-"/etc/valhalla.json"}
ENV MATCHER_TILE_EXTRACT ${MATCHER_TILE_EXTRACT:-"tiles.tar"}
ENV MATCHER_BIND_ADDR ${MATCHER_BIND_ADDR:-"0.0.0.0"}
ENV MATCHER_LISTEN_PORT ${MATCHER_LISTEN_PORT:-"8002"}
ENV MATCHER_SIGMA_Z ${MATCHER_SIGMA_Z:-"4.07"}
ENV MATCHER_BETA ${MATCHER_BETA:-"3"}
ENV MATCHER_DISTANCE_FACTOR ${MATCHER_DISTANCE_FACTOR:-"5"}
ENV MATCHER_TIME_FACTOR ${MATCHER_TIME_FACTOR:-"2"}

ADD ./ /reporter

# install dependencies
RUN apt-get update && apt-get install -y \
      python \
      python-requests \
      software-properties-common \
      maven \
      openjdk-8-jdk

RUN apt-add-repository -y ppa:valhalla-core/valhalla
RUN apt-get update && apt-get install -y \
      valhalla${VALHALLA_VERSION}-bin \
      python-valhalla${VALHALLA_VERSION}

# build java program
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-amd64
WORKDIR /reporter
RUN mvn install 2>&1 1>/dev/null
RUN mvn clean package
RUN ln -s /reporter/target/reporter-kafka /usr/local/bin/reporter-kafka

# install code & config
RUN valhalla_build_config \
      --mjolnir-tile-dir ${MATCHER_DATA_DIR} \
      --mjolnir-tile-extract ${MATCHER_DATA_DIR}/${MATCHER_TILE_EXTRACT} \
      --meili-default-sigma-z ${MATCHER_SIGMA_Z} \
      --meili-default-beta ${MATCHER_BETA} \
      --meili-default-max-route-distance-factor ${MATCHER_DISTANCE_FACTOR} \
      --meili-default-max-route-time-factor ${MATCHER_TIME_FACTOR} \
      >${MATCHER_CONF_FILE}

# cleanup
RUN apt-get clean && \
      rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE ${MATCHER_LISTEN_PORT}

CMD /reporter/py/reporter_service.py ${MATCHER_CONF_FILE} ${MATCHER_BIND_ADDR}:${MATCHER_LISTEN_PORT}
