FROM golang as builder  
WORKDIR /go/src/github.com/ancientlore/hurl  
ADD . .  
RUN CGO_ENABLED=0 GOOS=linux go get .  
RUN CGO_ENABLED=0 GOOS=linux go install  
  
FROM alpine:latest  
RUN apk --no-cache add ca-certificates tzdata  
WORKDIR /  
COPY \--from=builder /go/bin/hurl /usr/bin/hurl  
EXPOSE 8080  
ENTRYPOINT ["tail", "-f", "/dev/null"]  

