FROM kevin/sandstorm

RUN curl https://go.googlecode.com/files/go1.2.1.linux-amd64.tar.gz | tar xz -C /usr/local/
ENV PATH ${PATH}:/usr/local/go/bin

RUN apt-get update
RUN apt-get install -y busybox debootstrap

ADD shell /go/src/github.com/kevinwallace/sandstorm-shell/shell
ENV GOPATH /go

ADD make.sh /root/
ADD manifest.capnp /root/
ADD secret.key /root/
CMD /root/make.sh