FROM golang:1.7.1-alpine  
MAINTAINER Brian Lachniet <blachniet@gmail.com>  
  
COPY . $GOPATH/src/github.com/blachniet/timetonight  
WORKDIR $GOPATH/src/github.com/blachniet/timetonight  
  
RUN go build ./cmd/timetonight  
RUN go install $(go list ./... | grep -v /vendor/)  
  
EXPOSE 3000  
CMD ["timetonight"]

