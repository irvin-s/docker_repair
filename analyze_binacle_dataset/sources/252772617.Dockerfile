FROM golang:1.6  
MAINTAINER Benjamin Vickers <bv@benjvi.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update  
  
RUN apt-get -y install build-essential cmake git golang-go make mercurial  
  
ENV CGOENABLED 1  
ENV GOPATH /opt  
ENV BUILDDIR $GOPATH/src/github.com/hashicorp/terraform  
ENV PATH $PATH:$GOPATH/bin  
  
#Install Gox  
RUN go get -u github.com/mitchellh/gox  
  
ADD . $BUILDDIR  
  
RUN cd $BUILDDIR && make updatedeps && make && make dev  
  
ENTRYPOINT ["/opt/bin/terraform"]  

