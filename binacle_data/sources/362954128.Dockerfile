FROM golang:1.5

ADD . /go/src/github.com/IBM-Bluemix/go-hello-world

# Build the outyet command inside the container.
# (You may fetch or manage dependencies here,
# either manually or with a tool like "godep".)
RUN cd /go/src/github.com/IBM-Bluemix/go-hello-world;make

# Run the outyet command by default when the container starts.
ENTRYPOINT cd /go/src/github.com/IBM-Bluemix/go-hello-world/;./go-hello-world

# Document that the service listens on port 8080.
EXPOSE 8080