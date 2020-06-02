FROM openjdk:8

COPY /target/rubicon-bot.jar rubicon-bot.jar
COPY config.json config.json
ENTRYPOINT ["java", "-jar", "rubicon-bot.jar"]