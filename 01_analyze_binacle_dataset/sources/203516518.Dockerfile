FROM maven:3.3.9-jdk-8

ADD pom.xml /build/
RUN cd /build && mvn dependency:resolve

ADD src /build/src

RUN cd /build && mvn -DskipTests=true package \
       && cp /build/target/*.jar /app.jar \
       && bash -c 'touch /app.jar' \
       && cd / && rm -rf /build

ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]