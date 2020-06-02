FROM openjdk:8-jdk-alpine as builder

ARG WORKDIR="/app"

WORKDIR ${WORKDIR}

COPY build.gradle gradlew gradle.properties ${WORKDIR}/
COPY gradle ${WORKDIR}/gradle
# The task `gradle dependencies` will list the dependencies and download them as a side-effect.
RUN ./gradlew --no-daemon clean dependencies --configuration runtime
COPY . ${WORKDIR}
RUN ./gradlew --no-daemon assemble


FROM openjdk:8-jdk-alpine

LABEL maintainer="Jose Armesto <jose@armesto.net>"

ARG WORKDIR="/app"

WORKDIR ${WORKDIR}

EXPOSE 8080

ENTRYPOINT ["/sbin/tini", "--"]
# Change the name of the jar file with your own name
CMD ["java", "-jar", "app.jar"]

ENV JAVA_TOOL_OPTIONS "-XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap -XX:MaxRAMFraction=2"

RUN apk add --update ca-certificates tini=0.16.1-r0; \
    rm -rf /var/cache/apk/* /tmp/*

COPY --from=builder ${WORKDIR}/build/libs/*.jar ${WORKDIR}/
