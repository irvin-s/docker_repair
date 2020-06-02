FROM gradle:4.2.1-jdk8-alpine AS BUILDER

WORKDIR /sample

COPY / /sample

USER root

RUN chown -R gradle /sample

USER gradle

RUN gradle export

FROM openjdk:8-jre-alpine

WORKDIR /root

COPY --from=BUILDER /sample/apio-architect-sample/build/distributions/executable/sample.jar .
COPY --from=BUILDER /sample/apio-architect-sample/logback.xml .

ENTRYPOINT ["java", "-jar", "sample.jar"]