FROM ubuntu:trusty
MAINTAINER  Jessica Frazelle <github.com/jfrazelle>

# install dependencies
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -yq \
    bzr \
    curl \
    git \
    mercurial \
    software-properties-common \
    --no-install-recommends

# Install Go
RUN curl -s https://storage.googleapis.com/golang/go1.3.linux-amd64.tar.gz | tar -C /usr/local -xvz
RUN mkdir -p /go
ENV PATH    /usr/local/go/bin:$PATH
ENV GOPATH  /go

COPY . /src

WORKDIR /src

CMD go run app.go