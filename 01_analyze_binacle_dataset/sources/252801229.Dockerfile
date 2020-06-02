FROM golang:latest  
  
RUN go get github.com/onsi/ginkgo/ginkgo && go get github.com/onsi/gomega

