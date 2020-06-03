FROM golang:1.10.0-alpine3.7 AS compile  
WORKDIR /go/src/github.com/utopia-planitia/docker-image-builder/  
COPY . dispatcher  
RUN CGO_ENABLED=0 GOOS=linux go install -a -installsuffix cgo ./dispatcher  
  
FROM scratch  
COPY \--from=compile /go/bin/dispatcher /dispatcher  
ENTRYPOINT ["/dispatcher"]  

