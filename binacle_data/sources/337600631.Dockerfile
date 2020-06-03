# build stage
FROM golang:1.9.7-windowsservercore-1803 AS build-env
SHELL ["powershell", "-Command", "$ErrorActionPreference = 'Stop'; $ProgressPreference = 'SilentlyContinue';"]

ADD . /go/src/github.com/yangl900/log2oms
WORKDIR /go/src/github.com/yangl900/log2oms/
# RUN go test -v; CGO_ENABLED=0 GOOS=windows go build -o log2oms
#the test environment isn't working but this will generate the .exe
RUN go build -o log2oms.exe

# # final stage
FROM microsoft/nanoserver:1803

# RUN apk add --no-cache ca-certificates

WORKDIR /log2oms
COPY --from=build-env /go/src/github.com/yangl900/log2oms/log2oms.exe log2oms.exe

ENTRYPOINT log2oms.exe