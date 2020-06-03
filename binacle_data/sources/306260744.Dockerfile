FROM golang:1.7
MAINTAINER Roman Atachiants "roman@misakai.com"

# copy the local package files to the container's workspace.
ADD . /go/src/github.com/kelindar/stock-explorer
RUN go get golang.org/x/net/html
RUN go get github.com/akrennmair/goauth
RUN go get github.com/emitter-io/go

ADD deploy.sh /

# set the entry point
#ENTRYPOINT /go/bin/stock-explorer

CMD ["/bin/bash", "/deploy.sh"]