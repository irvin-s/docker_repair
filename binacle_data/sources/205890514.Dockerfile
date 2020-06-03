FROM java:alpine
COPY run.jar /usr/vertx/run.jar
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ENTRYPOINT ["java"]
CMD ["-jar", "/usr/vertx/run.jar"]