FROM golang:1.4  
ADD . /go/src/github.com/curt-labs/GoQueue  
WORKDIR /go/src/github.com/curt-labs/GoQueue  
RUN go get  
RUN go install github.com/curt-labs/GoQueue  
  
ENTRYPOINT ["/go/bin/GoQueue"]

