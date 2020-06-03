FROM brimstone/ubuntu:15.04  
MAINTAINER brimstone@the.narro.ws  
  
# TORUN  
ENV GOPATH /go  
  
EXPOSE 80  
# Set our command  
ENTRYPOINT ["/go/bin/goiardi"]  
CMD ["-c", "/etc/goiardi/goiardi.conf" ]  
  
VOLUME /etc/goiardi/data  
  
# Install the packages we need, clean up after them and us  
RUN package --list /tmp/dpkg.log git golang ca-certificates mercurial gcc \  
  
&& go get -v github.com/ctdk/goiardi \  
  
&& package --purge /tmp/dpkg.log \  
&& rm -rf $GOPATH/src \  
&& rm -rf $GOPATH/pkg  
  
COPY goiardi.conf /etc/goiardi/  

