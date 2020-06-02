FROM golang:1.10-alpine  
  
ENV SEABIRD_CONFIG /data/seabird.toml  
VOLUME /data  
  
RUN apk add --update iputils git  
  
ADD . /go/src/github.com/belak/go-seabird  
  
RUN go get -v -d github.com/belak/go-seabird/cmd/seabird  
RUN go install github.com/belak/go-seabird/cmd/seabird  
  
ENTRYPOINT ["/go/bin/seabird"]  

