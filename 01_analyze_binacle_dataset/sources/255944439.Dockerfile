FROM golang

ADD . /go/src/github.com/itsbalamurali/parse-server

RUN go install github.com/itsbalamurali/parse-server

ENTRYPOINT /go/bin/parse-server

EXPOSE 8080