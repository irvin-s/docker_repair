FROM openjdk:8u181-jre-alpine
MAINTAINER ClouDesire "dev@cloudesire.com"

ENV JAVA_OPTS_REQUIRED -XX:+UnlockExperimentalVMOptions \
                       -XX:+UseCGroupMemoryLimitForHeap

ENV JAVA_OPTS ''

VOLUME /tmp

RUN apk add --no-cache --update openssl

ADD target/janine-0.1.0-SNAPSHOT.jar /usr/local/java/janine.jar

CMD exec java $JAVA_OPTS_REQUIRED $JAVA_OPTS -jar /usr/local/java/janine.jar
