ARG GO_VERSION=1.8
FROM golang:${GO_VERSION}
ADD . /src
WORKDIR /src
RUN go build -o hello
CMD ["./hello"]
