FROM golang:latest  
  
MAINTAINER DJ Enriquez <dj.enriquez@infospace.com>  
  
RUN go get "github.com/hashicorp/consul/api" "github.com/docopt/docopt-go"  
  
WORKDIR /go/src/github.com/djenriquez/consul-backup  
ADD . /go/src/github.com/djenriquez/consul-backup  
  
RUN go build  
  
ENTRYPOINT ["./consul-backup"]  
  
CMD ["-h"]

