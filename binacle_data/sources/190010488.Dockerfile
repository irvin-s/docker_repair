FROM maven:3-jdk-8

MAINTAINER Dmitry Ustalov <dmitry.ustalov@gmail.com>

EXPOSE 8080 8081

ENV MAVEN_OPTS=-Dmaven.test.skip=true\ -Dmaven.javadoc.skip=true\ -Dmaven.repo.local=/mtsar/.m2\ -Duser.home=/var/maven \
    MAVEN_CONFIG=/var/maven/.m2

WORKDIR /mtsar

COPY README.md LICENSE pom.xml src mtsar.docker.sh /mtsar/

# Since the src directory is not copied itself, we need to
# do a couple of nasty things to make the build possible.

RUN \
mkdir -p $MAVEN_CONFIG && \
chown -R nobody $MAVEN_CONFIG && \
mkdir -p /mtsar/src /mtsar/log && \
mv -fv main /mtsar/src && \
mvn -T 4 -B package && \
mv -fv target/mtsar.jar mtsar.jar && \
mvn -B clean && \
rm -rf dependency-reduced-pom.xml /mtsar/.m2 && \
touch mtsar.docker.yml && \
chown -R nobody log mtsar.docker.yml && \
mv /mtsar/mtsar.docker.sh /mtsar/mtsar.sh

USER nobody

CMD ["/mtsar/mtsar.sh"]
