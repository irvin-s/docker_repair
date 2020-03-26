FROM golang:1.8

ADD . /go/src/github.com/Teradata/covalent-data
WORKDIR /go/src/github.com/Teradata/covalent-data
RUN go get && go install github.com/Teradata/covalent-data

ENTRYPOINT /go/bin/covalent-data

EXPOSE 8080
