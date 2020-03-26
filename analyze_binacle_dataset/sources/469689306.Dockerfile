# *******
# Build *
# *******
# Using slim image because main image has issues with missing SSL CA certificates
FROM openjdk:8-jdk-slim AS build

WORKDIR /app

# Install Gradle - running the wrapper help command will trigger depdenency download
COPY gradlew ./
COPY gradle ./gradle/
RUN ./gradlew help

# Retrieve all dependencies prior to copying source to avoid re-downloading every time source changes
COPY build.gradle settings.gradle ./
RUN ./gradlew download



# Copy the source code and perform the final build
ARG VERSION
COPY src ./src/
RUN ./gradlew build

# **************
# * Deployment *
# **************
FROM openjdk:8-jdk-slim

COPY --from=build /app/build/libs/demo-microservice.jar /app.jar
CMD [ "java", "-jar", "/app.jar" ]
