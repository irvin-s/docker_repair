# set author and base  
FROM fedora:26  
MAINTAINER Luis Pabón <lpabon@redhat.com>  
  
LABEL version="1.3.1"  
LABEL description="Development build"  
  
# let's setup all the necessary environment variables  
ENV BUILD_HOME=/build  
ENV GOPATH=$BUILD_HOME/golang  
ENV PATH=$GOPATH/bin:$PATH  
ENV HEKETI_BRANCH="master"  
# install dependencies, build and cleanup  
RUN mkdir $BUILD_HOME $GOPATH && \  
dnf -y install glide golang git make glibc-static && \  
dnf -y clean all && \  
mkdir -p $GOPATH/src/github.com/chinacoolhacker && \  
cd $GOPATH/src/github.com/chinacoolhacker && \  
git clone -b $HEKETI_BRANCH https://github.com/chinacoolhacker/heketi.git && \  
cd $GOPATH/src/github.com/chinacoolhacker/heketi && \  
glide install -v && \  
make && \  
cp heketi /usr/bin/heketi && \  
cp client/cli/go/heketi-cli /usr/bin/heketi-cli && \  
glide cc && \  
cd && rm -rf $BUILD_HOME && \  
dnf -y remove git glide golang && \  
dnf -y autoremove && \  
dnf -y clean all  
  
# post install config and volume setup  
ADD ./heketi.json /etc/heketi/heketi.json  
ADD ./heketi-start.sh /usr/bin/heketi-start.sh  
VOLUME /etc/heketi  
  
RUN mkdir /var/lib/heketi  
VOLUME /var/lib/heketi  
  
# expose port, set user and set entrypoint with config option  
ENTRYPOINT ["/usr/bin/heketi-start.sh"]  
EXPOSE 8080  

