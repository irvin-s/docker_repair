FROM apnar/nfs-ganesha

RUN DEBIAN_FRONTEND=noninteractive \
     && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 3FE869A9 \
     && echo "deb http://ppa.launchpad.net/gluster/nfs-ganesha-2.5/ubuntu xenial main" > /etc/apt/sources.list.d/nfs-ganesha-2.5.list \
     && echo "deb http://ppa.launchpad.net/gluster/libntirpc-1.5/ubuntu xenial main" > /etc/apt/sources.list.d/libntirpc-1.5.list \
     && echo "deb http://ppa.launchpad.net/gluster/glusterfs-3.13/ubuntu xenial main" > /etc/apt/sources.list.d/glusterfs-3.13.list \
     && apt-get update \
     && apt-get install -y nfs-ganesha-mem curl

RUN apt-get install -y fuse git gcc

RUN curl -L https://dl.google.com/go/go1.11.5.linux-amd64.tar.gz | tar -C /usr/local -xz

ENV PATH "$PATH:/usr/local/go/bin"
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH
RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
RUN go get github.com/onsi/ginkgo/ginkgo


RUN sed -i 's/VFS/MEM/' /start.sh
RUN sed -i 's#^EXPORT#NFSV4 \{ Graceless = true; \}\nEXPORT#' /start.sh
