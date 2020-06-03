FROM golang:1.6.2  
  
RUN go get -ldflags="-s -w" \  
github.com/mitchellh/gox \  
github.com/constabulary/gb/cmd/gb \  
github.com/alecthomas/gometalinter \  
github.com/opennota/check/cmd/structcheck \  
github.com/opennota/check/cmd/aligncheck \  
github.com/remyoudompheng/go-misc/deadcode \  
github.com/alecthomas/gocyclo \  
github.com/gordonklaus/ineffassign \  
github.com/mibk/dupl \  
github.com/golang/lint/golint \  
golang.org/x/tools/cmd/gotype \  
golang.org/x/tools/cmd/goimports \  
github.com/kisielk/errcheck \  
github.com/opennota/check/cmd/varcheck && \  
rm -rf /go/src/* /go/pkg/*  

