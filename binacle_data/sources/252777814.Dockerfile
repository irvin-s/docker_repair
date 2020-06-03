FROM golang:alpine  
  
WORKDIR /go/src/github.com/aoepeople/gitlab-crucible-bridge/  
  
COPY . .  
  
RUN go test  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .  
  
FROM alpine:3.6  
RUN apk --no-cache add ca-certificates  
  
WORKDIR /root/  
  
COPY \--from=0 /go/src/github.com/aoepeople/gitlab-crucible-bridge/app .  
  
CMD ["./app"]

