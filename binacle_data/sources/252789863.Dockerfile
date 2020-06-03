FROM golang:1.9  
WORKDIR /go/src/github.com/callstats-io/asgman/  
  
ADD main.go main.go  
ADD src/ src/  
ADD vendor/ vendor/  
  
RUN go install github.com/callstats-io/asgman  
  
ENTRYPOINT /go/bin/asgman  

