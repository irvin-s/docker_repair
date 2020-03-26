FROM openjdk:8u141-jdk

ENV APPLICATION_FILE dockerunit-spring-boot-example-0.0.1-SNAPSHOT.jar

# Set the location of the app
ENV APPLICATION_HOME /usr/local/demo-app

# Env variable that will be overidden by certain tests
ENV FOO FOO_FROM_IMAGE
ENV BAR BAR_FROM_IMAGE

EXPOSE 8080

# Copy your fat jar to the container
COPY target/$APPLICATION_FILE $APPLICATION_HOME/
COPY run-app /bin/

COPY application.properties /

# Launch the APPLICATION
WORKDIR $APPLICATION_HOME
CMD ["run-app"]
