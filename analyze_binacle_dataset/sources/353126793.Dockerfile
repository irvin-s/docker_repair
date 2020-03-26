FROM java:openjdk-8-jdk-alpine AS build

# build
COPY . /elastiquartz

RUN apk update && \
    apk add --virtual build-dependencies bash && \
    cd /elastiquartz && ./gradlew clean && \
    cd /elastiquartz && ./gradlew build

FROM java:openjdk-8-jdk-alpine
RUN mkdir -p /usr/local/elastiquartz/lib/
COPY --from=build /elastiquartz/build/libs/elastiquartz.jar /usr/local/elastiquartz/lib/

ENV CRON_LOCATION_TYPE="s3"
ENV EVENT_TARGET_TYPE="sqs"

EXPOSE 8080

ENTRYPOINT java $JAVA_OPTS -jar /usr/local/elastiquartz/lib/elastiquartz.jar
