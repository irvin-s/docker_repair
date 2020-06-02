FROM golang
ADD . /go/src/github.com/b3ntly/obits
RUN /go/src/github.com/b3ntly/obits/scripts/get_go_deps.sh
RUN go install github.com/b3ntly/obits/server
ENTRYPOINT /go/bin/server
EXPOSE 9090