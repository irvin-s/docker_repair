FROM registry.access.redhat.com/rhel7
RUN yum install -y git gcc make libtool-ltdl-devel unzip java-1.8.0-openjdk-devel
COPY setup.sh /tmp/setup.sh
RUN ./tmp/setup.sh
RUN mkdir /opt/gopath
ENV LD_LIBRARY_PATH=/usr/lib64
ENV GOPATH=/opt/gopath GOROOT=/opt/go
ENV PATH=$PATH:$GOROOT/bin:$GOPATH/bin
