FROM golang:alpine  
WORKDIR /go/src/github.com/gotoolkit/peony  
RUN apk add --no-cache git \  
&& go get -u github.com/golang/dep/cmd/dep  
COPY . /go/src/github.com/gotoolkit/peony  
RUN dep ensure \  
&& go build -o peony -tags=jsoniter cmd/peony/main.go  
  
FROM alpine:latest  
COPY \--from=0 /go/src/github.com/gotoolkit/peony/peony /usr/local/bin/peony  
EXPOSE 8000  
ENTRYPOINT ["peony"]  
CMD ["-h"]

