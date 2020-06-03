FROM golang:alpine  
COPY demo.go /go/  
RUN apk update && apk add git && \  
# need git installed to run 'go get' on github  
go get github.com/garyburd/redigo/redis && \  
# statically compile demo.go with all libraries built in  
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .  

