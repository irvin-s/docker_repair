FROM golang as builder  
WORKDIR /go/src/faxxr  
COPY . .  
RUN CGO_ENABLED=0 GOOS=linux go install  
  
FROM alpine:latest  
RUN apk --no-cache add ca-certificates tzdata  
  
COPY \--from=builder /go/bin/faxxr /root/faxxr  
COPY \--from=builder /go/src/faxxr/media /root/media  
RUN mkdir /root/tmp  
  
EXPOSE 9000/tcp  
WORKDIR /root  
  
CMD ["/root/faxxr"]  

