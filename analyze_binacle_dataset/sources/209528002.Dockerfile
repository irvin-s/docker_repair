FROM golang:1.6

# FUSE
RUN \
  apt-get update -yq && \
  apt-get install -yq --no-install-recommends \
    git \
    ca-certificates \
    curl \
    fuse && \
  apt-get clean && \
  rm -rf /var/lib/apt

# Install Pachyderm job-shim
RUN go get github.com/pachyderm/pachyderm && \
	go get github.com/pachyderm/pachyderm/src/server/cmd/job-shim && \
    cp $GOPATH/bin/job-shim /job-shim

# prepare the build environment
RUN apt-get update && apt-get install -y upx-ucl
RUN go get github.com/pwaller/goupx

VOLUME /src
WORKDIR /src

COPY build_environment.sh /
COPY build.sh /
