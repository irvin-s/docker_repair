## -*- docker-image-name: "scaleway/ubuntu-coreos:latest" -*-
FROM scaleway/docker:amd64-latest
# following 'FROM' lines are used dynamically thanks do the image-builder
# which dynamically update the Dockerfile if needed.
#FROM scaleway/docker:armhf-latest	# arch=armv7l
#FROM scaleway/docker:arm64-latest	# arch=arm64
#FROM scaleway/docker:i386-latest		# arch=i386
#FROM scaleway/docker:mips-latest		# arch=mips
MAINTAINER Maartje Eyskens <maartje@innovatete.ch> (@meyskens)


# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter


# Install packages
RUN apt-get -q update                   \
 && apt-get --force-yes -y -qq upgrade  \
 && apt-get --force-yes install -y -q build-essential tar \
 && apt-get clean


# Install Go
RUN apt-get -y install golang  && \
    echo "export GOPATH=/usr/src/spouse" >> ~/.bashrc && \
    mkdir /usr/src/spouse

# Install Fleet
RUN cd /usr/src/ && \
    GOPATH=/usr/src/spouse go get golang.org/x/tools/cmd/cover && \
    wget https://github.com/coreos/fleet/archive/v0.11.5.tar.gz && tar xzf v0.11.5.tar.gz && mv fleet-0.11.5 fleet && cd fleet && \
    ./build && \
    ln -s /usr/src/fleet/bin/* /usr/bin/

# Install Etcd
RUN cd /usr/src/ && git clone https://github.com/coreos/etcd.git -b release-2.2 && \
    cd /usr/src/etcd && \
    ./build && \
    ln -s /usr/src/etcd/bin/* /usr/bin/ && \
    mkdir /var/lib/etcd

# Install flannel
RUN cd /usr/src && \
    git clone https://github.com/coreos/flannel.git && \
    cd flannel && ./build && \
    ln -s /usr/src/flannel/bin/* /usr/bin/

# Installing UFW
RUN apt-get -y install ufw && \
    sed -i "s/IPV6=yes/IPV6=no/g" /etc/default/ufw && \
    ufw default allow incoming

# Installing update-firewall
ADD ./overlay/usr/local/ /usr/local/
RUN cd /usr/local/update-firewall && \
    GOPATH=/usr/src/spouse GOBIN=$GOPATH/bin go get

# Patch rootfs
ADD ./overlay/etc/ /etc/
RUN systemctl disable docker; systemctl enable docker


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
