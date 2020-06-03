FROM fedora:22
MAINTAINER Jianwei Hou, jhou@redhat.com

RUN dnf install -y targetcli hostname

ADD init.sh /

ENTRYPOINT /init.sh
