FROM openjdk:8-jdk-alpine
COPY /target/hospital-service.jar hospital-service.jar
COPY "/src/main/resources" "/src/main/resources/"
EXPOSE 8000
ENTRYPOINT ["java","-jar","hospital-service.jar"]
