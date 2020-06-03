FROM vertx-nashorn:latest
COPY . /usr/src/app
EXPOSE 8080
# Debug
# CMD ["-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005", "-jar", "/usr/vertx/run.jar"]