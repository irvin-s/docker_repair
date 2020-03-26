FROM golang:latest  
  
MAINTAINER brendan@codeship.com  
  
RUN mkdir -p /go/src/github.com/beanieboi/docker-than-light-clients  
WORKDIR /go/src/github/com/beanieboi/docker-than-light-clients  
ADD . ./  
RUN go get ./...  
RUN go build -o main ./cmd/main.go  
CMD ["./main"]  
  

