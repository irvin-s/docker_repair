FROM golang:alpine  
  
ADD . /go/src/github.com/drhayt/coatlocker  
  
RUN export GOPATH=/go && \  
export CGO_ENABLED=0 && \  
export GOOS=linux && \  
cd /go/src/github.com/drhayt/coatlocker && \  
go install ./... && \  
rm -fR /go/src/github.com/drhayt/coatlocker  
  
EXPOSE 8443  
  
ENTRYPOINT ["/go/bin/coatlocker"]  
CMD ["--help"]

