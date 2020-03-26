FROM golang:latest  
MAINTAINER William Weiskopf <william@weiskopf.me>  
  
RUN apt-get update && apt-get install -y \  
git-annex \  
&& rm -rf /var/lib/apt/lists/* \  
&& go get github.com/encryptio/git-annex-remote-b2 \  
&& mkdir /repository  
  
WORKDIR /repository  
  

