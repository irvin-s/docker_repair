FROM java:8

RUN apt-get update
#RUN apt-get install bash
RUN apt-get install -y gradle

EXPOSE 8081
WORKDIR /project
VOLUME /c/Users/steve/projects/microservice-documentation-tool/example/customer-service:/project
ENTRYPOINT ["./gradlew", "bootrun"]