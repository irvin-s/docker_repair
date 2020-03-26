FROM centos  
MAINTAINER d9magai  
  
ENV GO_VERSION 1.6rc1.linux-amd64  
ENV GO_ARCHIVE_URL https://storage.googleapis.com/golang/go$GO_VERSION.tar.gz  
  
RUN yum update -y && yum install -y \  
centos-release-scl \  
&& yum clean all  
RUN yum update -y && yum install -y \  
git19 \  
&& yum clean all  
  
RUN curl -sL $GO_ARCHIVE_URL | tar xz -C /usr/local \  
&& ls -dF /usr/local/go/* | egrep -v 'bin|lib|pkg|src' | xargs rm -r  
ENV HOME /srv  
ENV GOPATH ${HOME}/go  
ENV PATH ${PATH}:${GOPATH}/bin:/usr/local/go/bin:/opt/rh/git19/root/usr/bin  
  
RUN go get github.com/revel/revel  
RUN go get github.com/revel/cmd/revel  
  
EXPOSE 9000  
WORKDIR ${HOME}  
  

