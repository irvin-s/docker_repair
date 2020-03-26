FROM openjdk:8-alpine

ARG SBT_VERSION
ENV SBT_VERSION=${SBT_VERSION:-0.13.12}

ADD https://repo.typesafe.com/typesafe/ivy-releases/org.scala-sbt/sbt-launch/$SBT_VERSION/sbt-launch.jar /usr/bin/sbt-launch.jar
COPY sbt.sh /usr/bin/sbt

RUN echo "==> [CAUTION] This may take several minutes!!!" \
    && sbt

ENTRYPOINT ["sbt"]
CMD ["help"]