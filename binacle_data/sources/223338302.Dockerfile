FROM openjdk:8u121-jdk-alpine

COPY app/app.jar /usr/local/app.jar

WORKDIR /usr/local/

EXPOSE 8080 50505

CMD ["java", \
    "-agentlib:jdwp=transport=dt_socket,address=50505,suspend=n,server=y", \
    "-jar", \
    "app.jar"]