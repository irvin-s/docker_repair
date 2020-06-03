FROM ubuntu:14.04

RUN apt-get update; apt-get install -y racoon iptables python

ADD ovs.tar.gz /
ADD /scripts /scripts
CMD /scripts/ovs-run

VOLUME /opt/ovs/etc