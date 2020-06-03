FROM ubuntu:18.04

RUN apt update && \
    apt install -y ca-certificates pkg-config zip g++ zlib1g-dev unzip python curl git

# Setup Go.
RUN mkdir -p /goroot && \
  curl https://storage.googleapis.com/golang/go1.11.1.linux-amd64.tar.gz | tar xzf - -C /goroot --strip-components=1
ENV GOROOT /goroot
ENV GOPATH /gopath
ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH
RUN go env
RUN go get -u github.com/golang/dep/cmd/dep

# Setup Bazel.
RUN curl -fSL https://github.com/bazelbuild/bazel/releases/download/0.20.0/bazel-0.20.0-installer-linux-x86_64.sh -o /tmp/bazel-install.sh && \
    chmod +x /tmp/bazel-install.sh && \
    /tmp/bazel-install.sh
RUN bazel version

# Cluster API AWS.
RUN go get -u sigs.k8s.io/cluster-api-provider-aws || true
RUN cd $GOPATH/src/sigs.k8s.io/cluster-api-provider-aws && \
  ls && \ 
  make dep-ensure

WORKDIR /gopath/src/sigs.k8s.io/cluster-api-provider-aws

CMD ["bash"]
