FROM openjdk:8u121-jre-alpine

RUN echo "Asia/Shanghai" > /etc/timezone

VOLUME /tmp

ADD spring-boot-practice.war app.war

RUN sh -c 'touch /app.war'
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.war"]
