FROM brimstone/ubuntu:14.04  
  
EXPOSE 8080  
  
RUN package golang git make mercurial \  
&& cd /tmp \  
&& export GOPATH=/tmp/go \  
&& export PATH=$PATH:$GOPATH/bin \  
&& echo "Installing go-bindata" \  
&& go get -v github.com/jteeuwen/go-bindata/go-bindata \  
&& (go get -v github.com/brimstone/docker-ui || true ) \  
&& cd $GOPATH/src/github.com/brimstone/docker-ui \  
&& make big \  
&& cp docker-ui / \  
&& apt-get remove \--purge -y golang git make \  
&& apt-get autoremove --purge -y \  
&& rm -rf $GOPATH  
  
ENTRYPOINT ["/docker-ui"]  

