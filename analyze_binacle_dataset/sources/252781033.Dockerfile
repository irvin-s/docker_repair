FROM golang:1.9-alpine AS builder  
WORKDIR /go/src/github.com/costacruise/gantry/  
RUN apk update && apk upgrade && \  
apk add \--no-cache bash git openssh && \  
go get -u github.com/golang/dep/cmd/dep  
COPY . .  
RUN dep ensure  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o gantry .  
  
FROM alpine:latest  
RUN apk --no-cache add ca-certificates  
WORKDIR /usr/local/bin  
COPY \--from=builder /go/src/github.com/costacruise/gantry/gantry .  
CMD ["gantry"]

