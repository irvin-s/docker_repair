FROM golang:1.9  
WORKDIR /go/src/github.com/dataprism/dataprism-logics  
COPY . .  
RUN go get -d -v \  
github.com/hashicorp/consul/api \  
github.com/hashicorp/nomad/api \  
github.com/sirupsen/logrus \  
github.com/gorilla/mux \  
github.com/golang-plus/errors \  
github.com/rs/cors  
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .  
  
FROM alpine:latest  
RUN apk --no-cache add ca-certificates  
WORKDIR /root/  
COPY \--from=0 /go/src/github.com/dataprism/dataprism-logics/app .  
CMD ["./app"]  
EXPOSE 6300

