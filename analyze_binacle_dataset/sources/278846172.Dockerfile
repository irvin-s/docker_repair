FROM openjdk:8-jdk-alpine
ADD ./target/backend-0.0.1-SNAPSHOT.jar ines.jar
CMD ["java","-jar","/ines.jar"]
