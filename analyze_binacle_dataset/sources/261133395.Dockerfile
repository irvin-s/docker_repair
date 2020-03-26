# Docker file for building an image that can be run in a container.  Pretty simple, just put the .jar in and expose the right ports
# Note that at run time the container will need to pass in environment variables for secrects, etc.
FROM maven:3.6 as build

RUN mkdir /repo
ADD . /repo

WORKDIR /repo

RUN mvn package

FROM openjdk:11-jre-slim

RUN mkdir /encryptor
WORKDIR /encryptor
COPY --from=build /repo/target/keyvault-endpointconnection-0.0.2.jar .

EXPOSE 80

CMD ["/usr/bin/java", "-jar", "keyvault-endpointconnection-0.0.2.jar", "--spring.profiles.active=swagger"]
