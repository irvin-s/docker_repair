FROM golang  
  
ADD . /go/src/github.com/codenamekt/mgo-api  
  
RUN go get github.com/codenamekt/mgo-api  
RUN go install github.com/codenamekt/mgo-api  
  
ENTRYPOINT /go/bin/mgo-api  
  
EXPOSE 8080

