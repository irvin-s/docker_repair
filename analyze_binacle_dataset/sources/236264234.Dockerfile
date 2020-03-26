FROM ubuntu:17.04

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		curl \
		pkg-config

ENV GOLANG_VERSION 1.8.3

RUN apt-get install -y ca-certificates
ENV capath /etc/ssl/certs/
ENV cacert /etc/ssl/certs/ca-certificates.crt
RUN curl -sL https://golang.org/dl/go1.8.3.linux-amd64.tar.gz|tar -C /usr/local -xzf -
ENV PATH /usr/local/go/bin:${PATH}
RUN	go version

ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH

RUN apt-get install -y git build-essential cmake xxd gdb && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt
RUN git clone https://github.com/iotaledger/ccurl
RUN cd ccurl && git submodule update --init --recursive
RUN cd ccurl && mkdir build && cd build && cmake .. && cmake --build . && mv bin/ccurl-cli /opt/ccurl

RUN go get -u github.com/Masterminds/glide

RUN mkdir -p /go/src/github.com/iotaledger/sandbox

COPY . /go/src/github.com/iotaledger/sandbox

WORKDIR /go/src/github.com/iotaledger/sandbox

RUN glide install

RUN go build -o sandbox-worker ./cmd/worker
CMD ["./sandbox-worker"]
