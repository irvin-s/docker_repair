FROM fedora:24
MAINTAINER Seth Jennings <sjenning@redhat.com>

RUN dnf install hostname coreutils bind-utils iputils -y && dnf clean all
ADD init.sh /
ADD curl.sh /
ADD cat.sh /

CMD ["/init.sh"]
