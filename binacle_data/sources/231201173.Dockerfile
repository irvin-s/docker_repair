FROM maven:3-jdk-8-alpine

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app


# selectively add the POM file
ADD pom.xml /usr/src/app/
# get all the downloads out of the way
RUN mvn verify clean --fail-never


ADD . /usr/src/app
ADD ./src/test/java/karate-config.js.example /usr/src/app/src/test/java/karate-config.js