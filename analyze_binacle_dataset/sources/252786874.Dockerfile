FROM golang:1.9-alpine  
RUN apk add --no-cache git  
RUN go get -u github.com/golang/dep/cmd/dep  
ADD . /go/src/github.com/bpiddubnyi/crawler  
WORKDIR /go/src/github.com/bpiddubnyi/crawler/  
RUN dep ensure -v  
WORKDIR /go/src/github.com/bpiddubnyi/crawler/cmd/crawler  
RUN go install  
WORKDIR /go/src/github.com/bpiddubnyi/crawler/cmd/crawler-stat  
RUN go install  
ENTRYPOINT ["crawler"]  

