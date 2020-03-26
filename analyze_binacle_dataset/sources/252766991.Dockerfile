FROM golang:1.9.0 AS builder  
WORKDIR /go/src/github.com/alcheagle/net-monitor  
COPY . .  
RUN go get -d -v  
RUN CGO_ENABLED=0 GOOS=linux go build  
  
FROM scratch  
# FROM alpine  
COPY \--from=builder /go/src/github.com/alcheagle/net-monitor/net-monitor .  
ENTRYPOINT ["/net-monitor"]  

