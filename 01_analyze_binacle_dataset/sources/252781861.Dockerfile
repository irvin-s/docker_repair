FROM alpine:latest  
MAINTAINER Chris Short <chris@chrisshort.net>  
  
ENV PATH /go/bin:/usr/local/go/bin:$PATH  
ENV GOPATH /go  
  
RUN apk add --no-cache \  
ca-certificates  
  
COPY . /go/src/github.com/chris-short/ghb0t  
  
RUN set -x \  
&& apk add --no-cache --virtual .build-deps \  
go \  
git \  
gcc \  
libc-dev \  
libgcc \  
&& cd /go/src/github.com/chris-short/ghb0t \  
&& go build -o /usr/bin/ghb0t . \  
&& apk del .build-deps \  
&& rm -rf /go \  
&& echo "Build complete."  
  
ENTRYPOINT [ "ghb0t" ]  

