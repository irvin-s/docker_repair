# Dockerfile used to build openshift-cucumber
# Run it with a volume mounted at /go/src/github.com/vbehar/openshift-cucumber :
# $ docker run -v $PWD:/go/src/github.com/vbehar/openshift-cucumber [...]

FROM golang:1.4.2

ENV BUILD_OS_ARCH="linux/amd64 darwin/amd64 windows/amd64"

RUN go get github.com/mitchellh/gox \
 && gox -build-toolchain -osarch="${BUILD_OS_ARCH}"

ENV GOPATH="/go/src/github.com/vbehar/openshift-cucumber/Godeps/_workspace:$GOPATH" \
    PATH="/go/src/github.com/vbehar/openshift-cucumber/Godeps/_workspace/bin:$PATH"

VOLUME /go/src/github.com/vbehar/openshift-cucumber

WORKDIR /go/src/github.com/vbehar/openshift-cucumber

CMD gox -output="build/{{.OS}}/{{.Arch}}/{{.Dir}}" -osarch="${BUILD_OS_ARCH}" -ldflags="-X main.gitCommit $(git rev-parse HEAD)"
