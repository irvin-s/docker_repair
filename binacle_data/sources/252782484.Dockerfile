FROM golang:1.7  
LABEL maintainer "clement@le-corre.eu" \  
eu.le-corre.go_lib_docker "github.com/yhat/go-docker"\  
eu.le-corre.go_lib_docker "github.com/gorilla/mux"\  
description "API rest for deploy container easily"  
  
ARG DOCKER_VERSION=17.03*  
  
ENV xtoken=1234 \  
GOPATH=$GOPATH:/go/api \  
GOBIN=$GOPATH/bin  
  
  
RUN apt-get update && \  
apt-get -y install \  
apt-transport-https \  
ca-certificates \  
curl \  
software-properties-common && \  
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \  
add-apt-repository \  
"deb [arch=amd64] https://download.docker.com/linux/debian \  
$(lsb_release -cs) \  
stable" && \  
apt-get update && \  
apt-get -y install docker-ce=$DOCKER_VERSION && \  
rm -rf /var/lib/apt/lists/*  
  
COPY api/ /go/api  
WORKDIR /go/api  
RUN go get  
  
EXPOSE 8080  
CMD ["go", "run", "*.go"]  

