FROM golang:1.10 as builder  
WORKDIR /go/src/github.com/arbourd/wellcharted/  
COPY . .  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o wellcharted .  
  
FROM alpine:latest  
RUN apk --no-cache add ca-certificates  
WORKDIR /root/  
COPY \--from=builder /go/src/github.com/arbourd/wellcharted/wellcharted .  
ENTRYPOINT ["./wellcharted"]  

