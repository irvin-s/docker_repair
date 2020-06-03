FROM golang:stretch  
  
RUN apt-get update \  
&& apt-get install \--yes jq xmlstarlet \  
&& go get github.com/digitalocean/doctl/cmd/doctl \  
&& ln -s $(go env GOPATH)/bin/doctl /usr/local/bin/doctl  

