FROM golang:1.9-alpine  
  
RUN apk add \--update git  
RUN go get -v github.com/golang/lint/golint  
RUN go get -v github.com/golang/dep/cmd/dep  
RUN go get -v github.com/kisielk/errcheck  
RUN rm -fr /var/cache/apk/*  

