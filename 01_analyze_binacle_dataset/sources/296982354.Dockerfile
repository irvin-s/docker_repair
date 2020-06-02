FROM java:8

LABEL Description="Staging image for tasks service app" Version="0.9"

WORKDIR /tmp/
ADD task-service-0.9.jar /tmp/
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "task-service-0.9.jar"]

