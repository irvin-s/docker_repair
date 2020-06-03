FROM openjdk:8-alpine

EXPOSE 8082
WORKDIR /usr/src/app

ADD target/movie-svc-0.0.1-SNAPSHOT.jar movie-svc-0.0.1.jar

CMD ["java", "-jar", "movie-svc-0.0.1.jar"]
