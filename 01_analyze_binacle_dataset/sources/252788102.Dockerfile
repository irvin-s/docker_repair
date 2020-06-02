FROM golang:1.7  
RUN go get github.com/golang/lint/golint golang.org/x/tools/cmd/goimports  
  
ENV CGO_ENABLED 0  
RUN go install -a std  
  
MAINTAINER Guillaume J. Charmes <gcharmes@leaf.ag>  
  
ENV APP_DIR $GOPATH/src/github.com/agrarianlabs/localdiscovery  
  
WORKDIR $APP_DIR  
  
ADD . $APP_DIR  
RUN go build -ldflags -d ./cmd/discover  
  
CMD ["./discover"]  

