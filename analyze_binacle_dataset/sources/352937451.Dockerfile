FROM cfinfrastructure/minimal
MAINTAINER https://github.com/cloudfoundry/mega-ci

# Install go
RUN wget https://storage.googleapis.com/golang/go1.7.3.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.7.3.linux-amd64.tar.gz && \
  rm -rf go1.7.3.linux-amd64.tar.gz

# Create directory for GOPATH
RUN mkdir -p /go/bin

# set GOPATH
ENV GOPATH /go

# add go and GOPATH/bin to PATH
ENV PATH $PATH:$GOPATH/bin:/usr/local/go/bin

# use the vendor experiment
ENV GO15VENDOREXPERIMENT 1

# install test dependencies
RUN go get github.com/onsi/ginkgo/...
RUN go get github.com/onsi/gomega/...

RUN chown -R testuser:testuser /go
