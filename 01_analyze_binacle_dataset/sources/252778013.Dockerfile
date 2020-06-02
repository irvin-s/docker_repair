FROM jpetazzo/dind:latest  
MAINTAINER Antoine POPINEAU <antoine.popineau@appscho.com>  
  
RUN apt update && apt install -y make git mercurial bzr  
  
ENV GO_VERSION 1.5  
RUN curl -sSL https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz \  
| tar -v -C /usr/local -xz  
  
ENV DOCKER_HOST 172.17.0.1:2375  
ENV PATH /go/bin:/usr/local/go/bin:$PATH  
ENV GOPATH /go:/go/src/app/_gopath  

