FROM golang:1.7  
  
RUN set -x \  
&& apt-get update \  
&& apt-get install -y cmake pkg-config \  
&& go get -d github.com/libgit2/git2go \  
&& cd /go/src/github.com/libgit2/git2go \  
&& git checkout next \  
&& git submodule update \--init \  
&& make install  

