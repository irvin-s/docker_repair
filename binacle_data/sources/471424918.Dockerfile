ARG JDK_VERSION=8

FROM openjdk:${JDK_VERSION}-jdk as build_env

COPY . /src
WORKDIR /src

RUN ./gradlew build 

FROM openjdk:${JDK_VERSION}-jre
COPY --from=build_env /src/build/libs/hello-spring-boot-*.jar /usr/run/hello-app.jar

WORKDIR /usr/run
CMD ["java","-jar","hello-app.jar"]
