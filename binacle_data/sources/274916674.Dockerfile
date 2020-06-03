# Configures our base image for running tests in CircleCI
FROM gocardless/pgsql-cluster-manager-base

# Install docker client, required to use Docker in Circle
RUN set -x \
    && curl "https://download.docker.com/linux/static/stable/x86_64/docker-17.06.2-ce.tgz" | tar xfvz - -C /tmp docker/docker \
    && mv /tmp/docker/docker /usr/bin/docker

# We need goreleaser to build the go binaries
ENV GORELEASER_VERSION=v0.37.0 \
    GORELEASER_SHA256=2d9c73195b9036acb48c9633e0d284d7cda12f6e178522b87d3867e775289d23
RUN set -x \
    && curl -L "https://github.com/goreleaser/goreleaser/releases/download/${GORELEASER_VERSION}/goreleaser_Linux_x86_64.deb" --output /tmp/goreleaser.deb \
    && echo "${GORELEASER_SHA256} /tmp/goreleaser.deb" | sha256sum -c \
    && dpkg -i /tmp/goreleaser.deb \
    && rm -v /tmp/goreleaser.deb

# Configure Golang environment
ENV GOROOT=/go PATH=$PATH:/go/bin:/usr/sbin
