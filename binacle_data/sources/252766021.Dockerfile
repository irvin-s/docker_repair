FROM golang:1.5  
ADD . /go/src/github.com/99designs/smartling  
RUN cd /go/src/github.com/99designs/smartling && go install ./...  
RUN mkdir /work  
WORKDIR /work  
  
ENTRYPOINT ["/go/bin/smartling"]  

