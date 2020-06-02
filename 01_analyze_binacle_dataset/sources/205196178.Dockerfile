FROM openjdk:8u92-jdk-alpine

RUN MAVEN_VERSION=3.3.9 \
 && cd /usr/share \
 && wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz -O - | tar xzf - \
 && mv /usr/share/apache-maven-$MAVEN_VERSION /usr/share/maven \
 && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

WORKDIR /home/lab
ENTRYPOINT ["java", "-DPROD_MODE=true", "-Xmx32m", "-jar", "target/words.jar"]
EXPOSE 8080

COPY pom.xml .
RUN mvn verify -DskipTests --fail-never

COPY src ./src
RUN mvn verify
