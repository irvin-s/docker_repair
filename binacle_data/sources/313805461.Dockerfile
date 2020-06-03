FROM openjdk:8u181-jre-alpine

WORKDIR /opt/notary

ARG JAR_FILE

COPY ${JAR_FILE} /opt/notary/app.jar

## Wait for script (see https://github.com/ufoscout/docker-compose-wait/)

ADD https://github.com/ufoscout/docker-compose-wait/releases/download/2.5.0/wait /opt/notary/wait
RUN chmod +x /opt/notary/wait
CMD /opt/notary/wait && java -jar /opt/notary/app.jar
