FROM openjdk:11-slim
MAINTAINER Torsten Werner

WORKDIR /usr/src/app

# download the gradle wrapper
COPY gradlew /usr/src/app/
COPY gradle /usr/src/app/gradle/
RUN ./gradlew --version

# build the project and run tests
COPY . /usr/src/app/
RUN ./gradlew build

CMD ["./gradlew", "run"]
