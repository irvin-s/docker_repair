FROM golang:1.8

WORKDIR /go/src/app
VOLUME /go/src/app
ENV CGO_ENABLED=0
RUN go get github.com/tockins/realize
CMD ["/go/bin/realize", "run"] 

# Mount your project as /go/src/app, for example:
# docker run --rm -it -v ~/go/src/github.com/lizrice/hello-container-world/Example1:/go/src/app lizrice/hello-realize 