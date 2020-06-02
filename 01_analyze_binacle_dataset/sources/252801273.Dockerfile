FROM golang:alpine as builder  
  
RUN apk add --no-cache git  
RUN go get github.com/gliderlabs/sigil/cmd  
RUN go install github.com/gliderlabs/sigil/cmd  
  
FROM alpine  
COPY \--from=builder /go/bin/cmd /usr/bin/sigil  
ENTRYPOINT ["sigil"]  

