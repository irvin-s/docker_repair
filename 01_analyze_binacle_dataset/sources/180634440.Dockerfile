FROM openjdk:8

WORKDIR /home/rundeck-slack-incoming-webhook-plugin
CMD ["bash", "./gradlew"]
