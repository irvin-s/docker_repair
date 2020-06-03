FROM golang:1.9.0 as builder  
WORKDIR /go/src/github.com/draganm/snitch  
COPY . .  
RUN CGO_ENABLED=0 GOOS=linux go install -a -installsuffix cgo .  
  
FROM alpine:3.6  
RUN apk --no-cache add ca-certificates  
WORKDIR /  
COPY \--from=builder /go/bin/snitch /  
RUN mkdir db  
CMD ["/snitch"]  
EXPOSE 8000  

