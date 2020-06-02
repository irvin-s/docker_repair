FROM maven:3.6-jdk-11 as build

COPY pom.xml /usr/src/app/pom.xml
RUN mvn -B -f /usr/src/app/pom.xml -s /usr/share/maven/ref/settings-docker.xml dependency:resolve-plugins dependency:resolve
COPY src /usr/src/app/src
RUN mvn -f /usr/src/app/pom.xml -B -s /usr/share/maven/ref/settings-docker.xml clean package

FROM openjdk:11-jre-slim-stretch
ENV APP_USER app
ENV APP_GROUP app

COPY --from=build /usr/src/app/target/frontend.jar app.jar

RUN addgroup ${APP_GROUP} && adduser --system --disabled-login -ingroup ${APP_GROUP} -uid 1000 ${APP_USER}
VOLUME /tmp

ONBUILD RUN chmod 755 /app.jar

USER ${APP_USER}

ENTRYPOINT [ "sh", "-c", "java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar" ]