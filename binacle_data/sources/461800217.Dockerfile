FROM centos

ADD nuage-cni-k8s /opt/cni/bin/nuage-cni-k8s
ADD nuage-cni-openshift /opt/cni/bin/nuage-cni-openshift
ADD dist/loopback /opt/cni/bin/loopback
ADD scripts/install-cni.sh /install-cni.sh
ADD cninetconf/k8s/nuage-net.conf /nuage-net.conf.k8s
ADD cninetconf/openshift/nuage-net.conf /nuage-net.conf.openshift
RUN yum -y install iptables

ENV PATH=$PATH:/opt/cni/bin
VOLUME /opt/cni
WORKDIR /opt/cni/bin
CMD ["/opt/cni/bin/nuage-cni-k8s"]
