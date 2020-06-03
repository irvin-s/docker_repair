FROM gradle:4.9.0

ENV DEBIAN_FRONTEND noninteractive
ENV APP_PATH /ferb

USER root
RUN mkdir $APP_PATH
RUN mkdir ${APP_PATH}/build
RUN mkdir ${APP_PATH}/lib

WORKDIR $APP_PATH
COPY buildSrc ./buildSrc
COPY config ./config
COPY docker ./docker
COPY gradle ./gradle
COPY src ./src
COPY build.gradle .
COPY entrypoint.sh .
COPY gradle.properties .
COPY gradlew .
COPY settings.gradle .
COPY docker/ferb-test/config/testConfig.yml ${APP_PATH}/config/testConfig.yml

ENTRYPOINT ["./gradlew", "--info", "--rerun-tasks", "functionalQATest"]
