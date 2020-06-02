FROM fedora:latest  
  
RUN set -e \  
&& dnf -y upgrade \  
&& dnf -y install git golang \  
&& dnf -y autoremove \  
&& dnf clean all  
  
ENV PATH ${PATH}:/go/bin  
ENV GOPATH /go  
  
RUN set -e \  
&& mkdir /go \  
&& go get github.com/magefile/mage \  
&& go get -d github.com/gohugoio/hugo \  
&& cd /go/src/github.com/gohugoio/hugo \  
&& mage vendor \  
&& mage install  
  
EXPOSE 1313  
  
ENTRYPOINT ["/go/bin/hugo"]  

