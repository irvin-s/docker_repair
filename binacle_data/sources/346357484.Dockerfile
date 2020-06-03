FROM alpine:3.1
RUN mkdir -p /go
RUN apk add --update \
            go \
            git \
            && export GOPATH=/go
ENV GOPATH /go
#COPY ./docker-viz.go /go/src/github.com/thenayr/docker-viz/docker-viz.go
WORKDIR /go
RUN mkdir -p /go/src/github.com/thenayr/docker-viz
RUN go get github.com/fsouza/go-dockerclient
RUN go get github.com/franela/goreq
ADD . /go/src/github.com/thenayr/docker-viz
RUN go install github.com/thenayr/docker-viz
#RUN go build -o /bin/docker-viz 
ENTRYPOINT ["/go/bin/docker-viz"]
