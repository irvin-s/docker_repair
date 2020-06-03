FROM openjdk:11-jre-slim

RUN apt-get update && apt-get install -yq openssl 
LABEL MAINTAINER="CasperLabs, LLC. <info@casperlabs.io>"

USER root 
WORKDIR /opt/docker 
ENTRYPOINT ["bin/casperlabs-client"]
CMD ["run"]

# Copy dependencies that rarely change.
COPY .docker/layers/3rd/ /opt/docker/lib
# Copy our own libraries which change with every build.
COPY .docker/layers/1st/ /opt/docker/lib
# Copy the starter scripts which can also change with versions.
COPY bin /opt/docker/bin