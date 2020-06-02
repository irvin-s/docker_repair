FROM golang AS build

# armv6, armv7, arm64, amd64, x390x, ...
ARG ARCH=amd64
# for arm only
ARG GOARM=

WORKDIR /go/src/github.com/hairyhenderson/hello/
COPY main.go /go/src/github.com/hairyhenderson/hello/
RUN GOOS=linux GOARCH=$ARCH GOARM=$GOARM go build -o /hello

FROM scratch

COPY --from=build /hello /hello
CMD ["/hello"]
