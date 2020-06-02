FROM openjdk:8-alpine

# Define working directory.
WORKDIR /opt/rtb-exchange

ARG APP_PATH

COPY $APP_PATH rtb-exchange.jar

ENV env "prod"

# Run rtb-exchange.
CMD java -Dconfig.resource=application.${env}.conf -jar rtb-exchange.jar

VOLUME ["/opt/rtb-exchange/logs"]

EXPOSE 8081
