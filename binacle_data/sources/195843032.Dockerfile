FROM ubuntu:14.04.3

ENV HOME /root
ENV PATH /usr/local/go/bin:$PATH
ENV CF_VERSION 6.14.1
ENV RTR_VERSION 2.3.0
ENV GO_VERSION 1.5.3

EXPOSE 80 443 2222
VOLUME ["/var/vcap/data/garden/aufs_graph"]
ENTRYPOINT ["/var/micropcf/provision"]

RUN \
  apt-get -qqy install software-properties-common && \
  add-apt-repository -y ppa:brightbox/ruby-ng && \
  apt-get -qqy update && \
  apt-get -qqy --force-yes dist-upgrade && \
  apt-get -qqy update && \
  apt-get -qqy install wget curl unzip zip jq psmisc \
    libruby2.1 ruby2.1 aufs-tools iptables dnsmasq openssh-client

RUN \
  curl -L "https://cli.run.pivotal.io/stable?release=linux64-binary&version=${CF_VERSION}&source=github-rel" | tar -C /usr/local/bin -xz && \
  curl -L "https://github.com/cloudfoundry-incubator/routing-api-cli/releases/download/${RTR_VERSION}/rtr-linux-amd64.tgz" | tar -C /usr/local/bin -xz && \
  curl -L "https://storage.googleapis.com/golang/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /usr/local -xz && \
  /bin/echo 'conf-dir=/etc/dnsmasq.d' >> /etc/dnsmasq.conf && \
  /bin/echo -e 'user=root\nbind-interfaces' > /etc/dnsmasq.d/nanocf && \
  /bin/echo 'IGNORE_RESOLVCONF=yes' > /etc/default/dnsmasq

COPY assets /opt/bosh-provisioner/assets
COPY config.json /opt/bosh-provisioner/
COPY provision /var/micropcf/
COPY nanocf nanocf-test /usr/local/bin/
