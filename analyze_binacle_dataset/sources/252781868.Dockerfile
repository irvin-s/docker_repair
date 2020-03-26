FROM christianalexander/tinynode  
MAINTAINER Christian Alexander <calexanderdev@gmail.com>  
  
ENV CONSUL_VERSION=0.5.2  
  
# Download and install Consul  
# Consul is available in /usr/local/bin  
RUN export GOPATH=/go && \  
apk add \--update go git gcc musl-dev make bash && \  
go get github.com/hashicorp/consul && \  
cd $GOPATH/src/github.com/hashicorp/consul && \  
git checkout -q --detach "v$CONSUL_VERSION" && \  
make && \  
mv bin/consul /bin && \  
rm -rf $GOPATH && \  
apk del go gcc musl-dev make bash && \  
rm -rf /var/cache/apk/*  
  
EXPOSE 8301 8301/udp  

