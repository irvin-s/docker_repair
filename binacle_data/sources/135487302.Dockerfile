FROM openjdk:8-jdk AS builder

# tools
RUN apt-get update && \
    apt-get install -y maven && \
    rm -rf /var/lib/apt/lists/*

# working directory
RUN useradd --create-home app && \
    mkdir -p /project && \
    chown app /project
WORKDIR /project
USER app

# cache Maven dependencies
COPY --chown=app pom.xml /project/
RUN mvn dependency:go-offline --batch-mode --errors
LABEL cache-this-layer=liipi-api-builder-cache

# do the build
COPY --chown=app web/src/assets/translations-*.json /project/web/src/assets/
COPY --chown=app src /project/src/
# TODO: add --offline flag after finding out which plugin deps are not downloaded by go-offline
ARG version=1-SNAPSHOT
RUN mvn versions:set -DnewVersion="$version" -DgenerateBackupPoms=false --batch-mode --errors && \
    mvn clean package --batch-mode --errors

# ------------------------------------------------------------

FROM openjdk:8-jre-slim

RUN adduser --system --home /app app
WORKDIR /app
USER app

EXPOSE 8080
ENV SPRING_PROFILES_ACTIVE="docker,psql"
ENV TZ="Europe/Helsinki"
CMD ["java", "-Xmx400m", "-XX:MaxMetaspaceSize=64m", "-XX:+ExitOnOutOfMemoryError", "-jar", "liipi-api.jar"]

COPY --from=builder /project/target/liipi-api.jar /app/liipi-api.jar
