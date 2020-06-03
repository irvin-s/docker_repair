FROM dockerhub.hi.inet/dcip/minimal:alpine-3.6
LABEL maintainer Jorge Lorenzo <jlorgal@gmail.com>

# Install packages for golang environment
RUN apk update && \
    apk add --no-cache git gcc make libc-dev go go-tools \
                       python2-dev py2-pip py-virtualenv \
                       zlib-dev jpeg-dev libxml2-dev libxslt-dev \
                       docker \
                       mongodb

# Install python packages for tests
RUN pip install lettuce python-Levenshtein requests docker-compose

# Configure mongodb data volume
RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db

USER contint

ARG GOPATH=/home/contint/go
ARG GOPROJECT=github.com/Telefonica/seed-golang
ENV PATH="$GOPATH/bin:${PATH}" \
    GOPATH="$GOPATH"

RUN echo "export GOPATH=\"$GOPATH\" PATH=\"$GOPATH/bin:${PATH}\"" >> /home/contint/.bashrc && \
    mkdir -p "$GOPATH/src/$GOPROJECT"

# Install golang packages
RUN go get -v github.com/golang/lint/golint \
              github.com/golang/dep/cmd/dep \
              github.com/t-yuki/gocover-cobertura \
              github.com/aktau/github-release

# Mount the source code of the project under GOPATH
WORKDIR $GOPATH/src/$GOPROJECT

# Switch to root user (required by dcip)
USER root
