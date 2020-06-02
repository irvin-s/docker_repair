FROM ubuntu:14.04

RUN apt-get update
RUN apt-get install -y uml-utilities build-essential wget python

WORKDIR /tmp
RUN wget http://openvswitch.org/releases/openvswitch-2.3.1.tar.gz
RUN tar -zxvf openvswitch-2.3.1.tar.gz

WORKDIR /tmp/openvswitch-2.3.1
RUN ./configure --prefix=/opt/ovs --localstatedir=/var
RUN make
RUN make install

ADD openvswitch-ipsec.init /opt/ovs/bin/openvswitch-ipsec.init
RUN cp debian/ovs-monitor-ipsec /opt/ovs/bin/ovs-monitor-ipsec; chmod +x /opt/ovs/bin/ovs-monitor-ipsec