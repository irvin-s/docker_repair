# build stage  
FROM golang:1.10.1 AS build-env  
RUN mkdir -p /go/src/app  
WORKDIR /go/src/app  
  
ADD Gopkg.lock ./Gopkg.lock  
ADD Gopkg.toml ./Gopkg.toml  
  
RUN go get github.com/golang/dep/cmd/dep  
RUN dep ensure --vendor-only  
  
ADD *.go /go/src/app/  
RUN GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -o clickhouse-bulk  
  
# final stage  
FROM alpine  
WORKDIR /app  
COPY \--from=build-env /go/src/app/clickhouse-bulk .  
  
EXPOSE 80  
ENTRYPOINT ./clickhouse-bulk  

