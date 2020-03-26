FROM openjdk:8-jdk-alpine as builder
RUN mkdir -p /usr/src/myapp
COPY . /usr/src/myapp
WORKDIR /usr/src/myapp
RUN apk add --no-cache bash
RUN ./gradlew stage

FROM openjdk:8-jre-alpine
LABEL maintainer="devops@breakoutevent.onmicrosoft.com"
WORKDIR /usr/src/myapp
COPY --from=builder /usr/src/myapp/app.jar .
EXPOSE 8082
CMD ["java", "-jar", "/usr/src/myapp/app.jar"]
