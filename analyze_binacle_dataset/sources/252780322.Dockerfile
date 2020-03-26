FROM gliderlabs/alpine:3.4  
  
RUN apk add \--no-cache git go  
  
ENV GOPATH /go  
ENV PATH /go/bin:$PATH  
  
COPY bin/proxy-link /usr/bin/proxy-link  
  
WORKDIR /go/src/github.com/convox/proxy  
COPY . /go/src/github.com/convox/proxy  
RUN go install ./...  
  
ENTRYPOINT ["proxy-link"]  

