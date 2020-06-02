FROM openjdk:11-jre-slim

RUN apt-get update && apt-get install -yq openssl
LABEL MAINTAINER="CasperLabs, LLC. <info@casperlabs.io>"

USER root
WORKDIR /opt/docker
# HOME points to /root
RUN mkdir -p /root/.casperlabs/genesis
RUN mkdir -p /root/.casperlabs/deploy
ENTRYPOINT ["bin/casperlabs-node"]
CMD ["run"]


# Copy dependencies that rarely change.
COPY .docker/layers/3rd/ /opt/docker/lib
# Copy our own libraries which change with every build.
COPY .docker/layers/1st/ /opt/docker/lib
# Copy the starter scripts which can also change with versions.
COPY bin /opt/docker/bin