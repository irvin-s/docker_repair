FROM gradle

ENV DEBIAN_FRONTEND noninteractive
ENV APP_PATH /ferb
ENV GRADLE_CACHE ${APP_PATH}/build/gradle_cache

USER root
RUN mkdir $APP_PATH
RUN mkdir ${APP_PATH}/lib
RUN mkdir ${APP_PATH}/build
RUN mkdir ${GRADLE_CACHE}

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
COPY build/gradle_cache ${GRADLE_CACHE}
COPY docker/ferb-test/config/testConfig.yml ${APP_PATH}/config/testConfig.yml

RUN ./gradlew build -x test -x functionalQATest --gradle-user-home=${GRADLE_CACHE} --refresh-dependencies
ENTRYPOINT ["./gradlew", "--info", "--rerun-tasks", "smokeTest"]