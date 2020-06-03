FROM golang:1.8.3  
COPY . /go/src/github.com/croomes/fiord  
WORKDIR /go/src/github.com/croomes/fiord  
RUN go get && make build  
  
FROM alpine:latest  
COPY \--from=0 /go/src/github.com/croomes/fiord/fiord /bin/fiord  
ENTRYPOINT ["/bin/fiord"]  
  
EXPOSE 9300

