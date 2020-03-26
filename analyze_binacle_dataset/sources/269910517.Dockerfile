FROM maven:latest AS appserver
WORKDIR /usr/src/ddev
COPY pom.xml .
RUN mvn -B -f pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve
COPY . .
RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package -DskipTests

FROM java:8-jdk-alpine
RUN adduser -Dh /home/gordon gordon
WORKDIR /app
COPY --from=appserver /usr/src/ddev/target/ddev-0.0.1-SNAPSHOT.jar .
ENTRYPOINT ["java", "-jar", "/app/ddev-0.0.1-SNAPSHOT.jar"]
CMD ["--spring.profiles.active=postgres"]