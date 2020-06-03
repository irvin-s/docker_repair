FROM selenium/standalone-chrome

ENV APP_PATH /api

USER root
RUN mkdir $APP_PATH
RUN mkdir ${APP_PATH}/lib
RUN mkdir ${APP_PATH}/build

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


RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  software-properties-common && \
    add-apt-repository ppa:webupd8team/java -y && \
    apt-get update && \
    echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections && \
    apt-get -y install openjdk-8-jdk && \
    apt-get clean

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV CHROME_DRIVER="/usr/bin/chromedriver"

ENTRYPOINT ["./gradlew", "--info", "--rerun-tasks", "smokeTest"]
