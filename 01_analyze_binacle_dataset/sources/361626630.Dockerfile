#
#

# pull base image.
FROM jamesdbloom/docker-java8-maven

MAINTAINER Tomas Dvorak <tomas.dvorak@skidata.com>

ADD pom.xml pom.xml

# caching, include all the dependencies into the build
RUN mvn dependency:go-offline
RUN mvn dependency:resolve-plugins

ADD src src

RUN mvn clean

# install wildfly or any other resources needed by arquillian
RUN mvn process-test-classes

RUN chmod -R 777 .

CMD ["mvn", "test"]
