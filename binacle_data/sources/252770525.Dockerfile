FROM golang:1.10 as builder  
WORKDIR /go/src/github.com/asserchiu/go-http-replier/  
COPY * ./  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .  
  
FROM scratch  
WORKDIR /root/  
COPY \--from=builder /go/src/github.com/asserchiu/go-http-replier/app .  
CMD ["./app"]  

