FROM golang:1.8-alpine  
RUN apk --no-cache update && \  
apk --no-cache add ca-certificates git curl make openssh-client \  
&& rm -rf /var/cache/apk/*  
RUN go get github.com/Masterminds/glide \  
&& cd /go/src/github.com/Masterminds/glide \  
&& git checkout 8460774 \  
&& make install  
ENTRYPOINT ["/usr/local/bin/glide"]  

