FROM openjdk:8-jre-alpine

WORKDIR /opt

ADD target/vertx-mqtt-broker-2.2.13-fat.jar mqtt-broker.jar
ADD config.json config.json
ADD entrypoint.sh entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
CMD ["-c", "/opt/config.json"]
