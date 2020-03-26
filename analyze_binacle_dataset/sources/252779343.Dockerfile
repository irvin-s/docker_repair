FROM alpine:3.2  
MAINTAINER Carlos Alexandro Becker <caarlos0@gmail.com> (@caarlos0)  
  
RUN apk add -U \  
curl \  
git \  
mercurial \  
bzr \  
go && \  
rm -rf /var/cache/apk/*  
  
ENV GOROOT /usr/lib/go  
ENV GOPATH /gopath  
ENV GOBIN /gopath/bin  
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin  

