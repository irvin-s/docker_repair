FROM golang:nanoserver AS build

WORKDIR /go/src/github.com/hairyhenderson/hello/
COPY main.go /go/src/github.com/hairyhenderson/hello/
RUN go build -o /hello.exe

FROM microsoft/nanoserver

COPY --from=build /hello.exe /hello.exe

CMD ["/hello.exe"]
