FROM frolvlad/alpine-java:jdk8-slim  AS build
WORKDIR /app/springbootapp/

## copy maven project
COPY . .
RUN apk add --no-cache maven
RUN mvn clean package

## Runtime
FROM frolvlad/alpine-java:jre8-slim AS runtime
WORKDIR /app
COPY --from=build /app/springbootapp/target/app.jar ./
EXPOSE 8081
ENTRYPOINT ["java", "-jar", "app.jar","--spring.profiles.active=h2"]
