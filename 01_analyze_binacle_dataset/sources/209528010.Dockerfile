FROM golang:latest

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

# add the filter binary (created with the Makefile)
ADD repofilter /repofilter
