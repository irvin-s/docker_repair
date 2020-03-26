FROM golang:alpine as builder  
RUN apk --no-cache add git  
WORKDIR /go/src/app  
COPY . .  
RUN go get -d ./...  
RUN go install ./...  
  
FROM alpine:latest  
RUN apk --no-cache add ca-certificates  
WORKDIR /app  
COPY \--from=builder /go/bin/app .  
EXPOSE 8080  
CMD ["./app"]

