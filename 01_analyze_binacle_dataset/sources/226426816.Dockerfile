FROM rancher/agent-base:v0.3.0

RUN DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get -yy -q \
    install apt-transport-https \
    && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ wheezy main" > \
    /etc/apt/sources.list.d/azure-cli.list \
    && curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && DEBIAN_FRONTEND=noninteractive apt-get update -y \
    && DEBIAN_FRONTEND=noninteractive apt-get -yy -q \
    install \
    iptables \
    ca-certificates \
    file \
    util-linux \
    socat \
    curl \
    ethtool \
    nfs-common \
    jq \
    unzip \
    git \
    wget \
    glusterfs-client \
    ceph-fs-common \
    ceph-common \
    conntrack \
    netcat-openbsd \
    cifs-utils \
    azure-cli \
    open-iscsi \
    && DEBIAN_FRONTEND=noninteractive apt-get autoremove -y \
    && DEBIAN_FRONTEND=noninteractive apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -sLf https://get.docker.com/builds/Linux/x86_64/docker-1.12.3.tgz | tar xvzf - -C /usr/bin --strip-components=1 docker/docker-runc docker/docker \
    && mv /usr/bin/docker-runc /usr/bin/runc \
    && curl -sLf https://get.docker.com/builds/Linux/x86_64/docker-1.11.2.tgz | tar xvzf - -C /usr/bin --strip-components=1 docker/docker-runc \
    && mv /usr/bin/docker-runc /usr/bin/runc-1.11 \
    && mkdir -p /mnt/sda1 \
    && ln -s /var /mnt/sda1/var \
    && curl -sLf https://storage.googleapis.com/kubernetes-helm/helm-v2.1.3-linux-amd64.tar.gz | tar xvzf - -C /usr/bin --strip-components=1 linux-amd64/helm

ENV CNI v0.3.0-rancher3
RUN mkdir -p /opt/loopback/bin \
    && curl -sfSL https://github.com/rancher/cni/releases/download/${CNI}/cni-${CNI}.tar.gz | \
       tar xvzf - -C /tmp ./loopback \
    && mv /tmp/loopback /opt/loopback/bin
ENV SSL_SCRIPT_COMMIT 98660ada3d800f653fc1f105771b5173f9d1a019
RUN wget -O /usr/bin/update-rancher-ssl https://raw.githubusercontent.com/rancher/rancher/${SSL_SCRIPT_COMMIT}/server/bin/update-rancher-ssl && \
    chmod +x /usr/bin/update-rancher-ssl

COPY runc-1.10 utils.sh entry.sh addons-update.sh kubectl kubelet kube-proxy kube-apiserver kube-controller-manager kube-scheduler /usr/bin/
COPY kubernetes/cluster/addons /etc/kubernetes/addons/

RUN curl -OL https://github.com/rancher/cli/releases/download/v0.6.1/rancher-linux-amd64-v0.6.1.tar.gz \
    && tar xf rancher-linux-amd64-v0.6.1.tar.gz \
    && mv rancher-v0.6.1/rancher /usr/bin/

ENTRYPOINT ["/usr/bin/entry.sh"]
