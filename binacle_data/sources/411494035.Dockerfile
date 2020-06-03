FROM openjdk:8

ADD build/libs/app.jar /opt/web/app.jar

WORKDIR /opt/web

EXPOSE 8080

ENTRYPOINT ["java", "-Djava.security.egd=file:///dev/urandom", "-jar", "/opt/web/app.jar"]
