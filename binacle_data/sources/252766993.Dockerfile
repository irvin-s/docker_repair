FROM golang:1.9.0 AS builder  
WORKDIR /go/src/github.com/alcheagle/simple_web_server  
COPY . .  
RUN go get -d -v  
RUN CGO_ENABLED=0 GOOS=linux go build  
  
FROM alpine  
COPY \--from=builder /go/src/github.com/alcheagle/simple_web_server .  
EXPOSE 8080  
ENTRYPOINT ["/simple_web_server"]  

