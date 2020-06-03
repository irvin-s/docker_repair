FROM alpine:3.2  
  
# Install docker-squash  
RUN apk add --update go git && \  
mkdir -p /tmp/docker-squash && \  
GOPATH=/tmp/docker-squash go get github.com/jwilder/docker-squash && \  
mv /tmp/docker-squash/bin/docker-squash /usr/local/bin/ && \  
apk del go git && \  
rm -rf /tmp/docker-squash /var/cache/apk/*  
  
# Install dependencies for docker-squash  
RUN apk add --update tar sudo && \  
rm -rf /tmp/docker-squash /var/cache/apk/*  
  
ENTRYPOINT ["/usr/local/bin/docker-squash"]  

