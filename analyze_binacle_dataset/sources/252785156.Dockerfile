FROM golang:1.7.3  
RUN go get github.com/tools/godep  
COPY . /go/src/github.com/Coffee-Lovers/WSServer  
WORKDIR /go/src/github.com/Coffee-Lovers/WSServer  
RUN godep restore  
RUN go build app.go  
  
EXPOSE 8085  
ENTRYPOINT ["./app"]

