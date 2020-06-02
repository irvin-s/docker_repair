FROM golang:1.7  
ADD . /go/src/github.com/cagiti/bshil  
  
RUN cd /go/src/github.com/cagiti/bshil;make  
  
ENTRYPOINT cd /go/src/github.com/cagiti/bshil/;go run main.go  
  
EXPOSE 8080  

