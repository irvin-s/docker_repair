FROM golang:1.10-alpine AS builder  
  
RUN apk -U add musl-dev gcc  
  
COPY . /go/src/github.com/brimstone/grada/  
  
WORKDIR /go/src/github.com/brimstone/grada/  
  
RUN go build -ldflags "-linkmode external -extldflags \"-static\" -s -w" -v  
  
FROM scratch  
  
ENV GRADA_PORT=3001  
EXPOSE 3001  
COPY \--from=builder /go/src/github.com/brimstone/grada/grada /grada  
  
ENTRYPOINT ["/grada"]  

