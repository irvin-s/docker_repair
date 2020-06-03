FROM golang:1.9.1-alpine  
  
RUN apk add --no-cache curl git  
  
ADD . /go/src/app  
RUN go get app  
RUN go install app  
  
ENTRYPOINT ["/go/bin/app"]

