FROM xena/go:1.10
ENV GOPATH /root/go
RUN apk --no-cache add git protobuf retool make
COPY . /root/go/src/github.com/pixeldothorse/pixeldothorse
WORKDIR /root/go/src/github.com/pixeldothorse/pixeldothorse
RUN make build
