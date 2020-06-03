FROM openjdk:8-jdk-stretch AS build
LABEL maintainer="Christian Müller <cmueller.dev@gmail.com>"
WORKDIR /toscana-build
ADD build-toscana.sh .
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y maven git
RUN ./build-toscana.sh
# This image Uses the Docker Socket as a volume
FROM docker:stable
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
ENTRYPOINT ./toscana-entrypoint.sh
