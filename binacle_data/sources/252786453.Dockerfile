FROM dockercraft/alpine:3.7  
MAINTAINER Daniel <daniel@topdevbox.com>  
  
# How-To  
# Local Build: docker build -t hugo .  
# Local Run: docker run -it hugo version  
  
  
ENV PACKAGES "g++ git go=1.9.4-r0"  
  
RUN apk add \--update $PACKAGES \  
&& export PATH=$PATH:/root/go/bin \  
&& go get -u -d github.com/magefile/mage \  
&& cd ${GOPATH:-$HOME/go}/src/github.com/magefile/mage \  
&& go run bootstrap.go \  
&& cp /root/go/bin/mage /bin/mage \  
&& go get -d github.com/gohugoio/hugo \  
&& cd ${GOPATH:-$HOME/go}/src/github.com/gohugoio/hugo \  
&& mage vendor \  
&& mage install \  
&& cp /root/go/bin/hugo /bin/hugo \  
&& cd ~ \  
&& rm -rf ${GOPATH:-$HOME/go}/src/* \  
&& rm -rf /var/cache/apk/*  

