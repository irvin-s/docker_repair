FROM openjdk:8-jdk-stretch AS build
LABEL maintainer="Christian Müller <cmueller.dev@gmail.com>"
WORKDIR /toscana-build
ADD build-toscana.sh .
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y maven git
RUN ./build-toscana.sh
# This image is based on the Docker in Docker image (needs --privileged to work correctly)
# If the privileged flag is missing this image will not support kubernetes based transformations
FROM docker:stable-dind
WORKDIR /toscana
VOLUME /toscana/data
# Mount the AWS Directory as volume (used to store Credentials)
VOLUME /root/.aws
COPY --from=build /toscana-build/server.jar server.jar
ADD *.sh /toscana/
RUN apk add --update --no-cache bash && \
    ./install-deps.sh && \
    ./cleanup.sh
EXPOSE 8080
ENV DATADIR="/toscana/data"
ENV SERVER_PORT="8080"
ENTRYPOINT ./toscana-dind-entrypoint.sh
