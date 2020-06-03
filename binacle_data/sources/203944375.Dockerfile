# Based on the image which openjdk:11-jre-slim is built on.
FROM debian:stretch-slim

LABEL MAINTAINER="CasperLabs, LLC. <info@casperlabs.io>"

USER root
WORKDIR /opt/docker

# Will need to mount a common volume to be used as a socket.
ENTRYPOINT ["casperlabs-engine-grpc-server"]
CMD [".casper-node.sock"]

# Install from debian package.
ADD ./casperlabs-engine-grpc-server*.deb /opt/docker/
# TODO: If I build on Ubuntu 16.04 the package installs without a problem,
# 		but if I use the casperlabs:buildenv image for packaging I get unmet dependencies.
# RUN apt-get update && \
#     apt install /opt/docker/casperlabs-engine-grpc-server*.deb && \
#     apt-get clean
RUN dpkg -i \
    --ignore-depends libgcc1 \
    --ignore-depends libc6 \
    --ignore-depends libstdc++6 \
    /opt/docker/casperlabs-engine-grpc-server*.deb