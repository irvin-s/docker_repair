FROM alekzonder/puppeteer:1.3.0 as client-builder
MAINTAINER Arturo Volpe <arturovolpe@gmail.com>
RUN whoami
ENV BUILD_FOLDER /home/pptruser/client
RUN mkdir "$BUILD_FOLDER"
WORKDIR $BUILD_FOLDER

COPY client/package.json "$BUILD_FOLDER"
COPY client/package-lock.json "$BUILD_FOLDER"

RUN npm install
COPY --chown=pptruser:pptruser client/. "$BUILD_FOLDER"
RUN npm run build

FROM maven:3.5.3-alpine as builder
ARG BRANCH_NAME
ARG SONAR_TOKEN
ARG CODACY_TOKEN
ARG CODACY_API_KEY
WORKDIR /app
COPY pom.xml /app
COPY src /app/src
COPY utils /app/utils

COPY --from=client-builder /home/pptruser/client/dist /app/src/main/resources/public
RUN sh ./utils/gen_licenses.sh
RUN mvn -B -q \
        package \
        sonar:sonar \
        -Dsonar.organization=avolpe-github \
        -Dsonar.host.url=https://sonarcloud.io \
        -Dsonar.login="$SONAR_TOKEN" \
        -Dsonar.branch.name="$BRANCH_NAME"

RUN mvn -B -q install -Ppostgres -DskipTests

FROM openjdk:8-jdk-alpine
VOLUME /tmp
COPY --from=builder /app/target/cotizaciones-1.2.0.jar app.jar
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/app.jar"]

