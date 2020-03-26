FROM golang:latest  
MAINTAINER Martin Lazarov <martin@lazarov.bg>  
  
RUN go get -u github.com/golang/lint/golint  
RUN go get -u github.com/kisielk/errcheck  
RUN go get -u github.com/alecthomas/gometalinter && gometalinter --install  

