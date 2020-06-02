FROM openjdk:11

COPY build/libs/kafka-hawk-*.jar /kafka-hawk.jar

ENTRYPOINT ["java", "-jar", "/kafka-hawk.jar"]
