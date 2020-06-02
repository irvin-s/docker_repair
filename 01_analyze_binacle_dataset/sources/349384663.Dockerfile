FROM fedora:22
MAINTAINER Jianwei Hou, jhou@redhat.com

RUN dnf install -y glusterfs-server attr hostname

Add init.sh /

ENTRYPOINT /init.sh
