FROM golang:1.4.2

ENV GOPATH=/
RUN mkdir -p /src/github.com/dynport/dgtk/wunderproxy
ADD . /src/github.com/dynport/dgtk/wunderproxy
RUN cd /src/github.com/dynport/dgtk/wunderproxy/wunderproxy && go build -o /bin/wunderproxy

ENTRYPOINT ["/bin/wunderproxy"]
