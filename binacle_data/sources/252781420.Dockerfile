FROM golang as builder  
  
WORKDIR /go/src/app  
COPY . .  
  
RUN go get -u github.com/golang/dep/cmd/dep && \  
dep ensure && \  
go build  
  
FROM debian:9-slim  
RUN apt update && \  
apt install -y ca-certificates && \  
apt-get clean  
COPY \--from=builder /go/src/app/app /usr/bin  
WORKDIR /data  
ENTRYPOINT ["app"]

