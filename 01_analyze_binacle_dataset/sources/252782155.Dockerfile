FROM golang:1.9.2 as builder  
WORKDIR /tmp  
COPY main.go .  
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o srv .  
RUN cp /usr/bin/curl .  
  
FROM alpine:latest  
WORKDIR /root/  
EXPOSE 80  
RUN apk add --no-cache curl  
COPY \--from=builder /tmp/srv .  
CMD ["./srv"]  

