FROM golang:1.9.3  
WORKDIR /go/src/app  
COPY server/server.go .  
  
RUN go get -d -v ./...  
RUN go install -v ./...  
  
EXPOSE 1234:1234/udp  
CMD ["app"]

