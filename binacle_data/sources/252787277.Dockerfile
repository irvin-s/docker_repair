FROM openjdk:8-jdk as builder  
COPY ./ ./  
RUN ./gradlew clean build  
  
FROM openjdk:8-jre-alpine  
COPY \--from=builder build/libs/barren-land.jar /barren-land.jar  
ENTRYPOINT java -jar barren-land.jar

