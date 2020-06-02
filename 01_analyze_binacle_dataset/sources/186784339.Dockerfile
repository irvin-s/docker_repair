# source environment
FROM scratch AS source

COPY ./ /src/

# build environment
FROM maven:3.5.4-jdk-8 AS builder

COPY --from=source /src/ /app/

WORKDIR /app

RUN set -x; mvn install -DskipTests=true

RUN mkdir /dist
RUN mv amy-master-node/target/amy-master-node.jar /dist/amy.jar
RUN mv build/plugins/ /dist/

# production
FROM openjdk:8-jre-slim

COPY --from=builder /dist/amy.jar /app/amy.jar
COPY --from=builder /dist/plugins /app/plugins

COPY --from=source /src/.docker/config /app/config

WORKDIR /app

ENV AMY_SOCKET_CONFIG_WEB_SOCKET_PORT 6661
ENV AMY_SERVER_CONFIG_SERVER_SOCKET_PORT 80
ENV AMY_SERVER_CONFIG_SERVER_URL http://localhost:80/
EXPOSE $AMY_SERVER_CONFIG_SERVER_SOCKET_PORT
EXPOSE $AMY_SOCKET_CONFIG_WEB_SOCKET_PORT

RUN mkdir /config

CMD ["java", "-jar", "amy.jar", "-c", "/config"]
