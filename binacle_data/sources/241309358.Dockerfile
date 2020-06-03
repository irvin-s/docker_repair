FROM rest4hub/golang-glide

ADD . /go/src/github.com/Nordstrom/ctrace-go
WORKDIR /go/src/github.com/Nordstrom/ctrace-go
RUN glide install
ENTRYPOINT go run ./demo/main.go
EXPOSE 8004
