FROM golang

RUN mkdir -p /go/src/enbase
WORKDIR /go/src/enbase
COPY . .
RUN curl -L -s https://github.com/golang/dep/releases/download/v0.3.1/dep-linux-amd64 -o $GOPATH/bin/dep
RUN chmod +x $GOPATH/bin/dep
RUN $GOPATH/bin/dep ensure
CMD go test enbase
