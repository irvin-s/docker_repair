# Compile stage
FROM golang:1.11.3-alpine3.8 AS build-env
ENV CGO_ENABLED 0
ADD . /go/src/subselect

RUN apk add git gcc libc-dev

RUN go get github.com/ioFog/iofog-go-sdk
RUN go build -gcflags "-N -l" --ldflags '-linkmode "external" -extldflags "-static"' -x -o /subselect subselect

FROM hypriot/rpi-alpine-scratch

COPY --from=build-env /go/src/subselect /go/bin

WORKDIR /go/bin
CMD ["./subselect"]