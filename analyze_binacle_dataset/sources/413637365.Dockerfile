FROM centos:7

RUN yum install -y -q sudo vim tree
RUN curl -fsSL https://repo.stns.jp/scripts/yum-repo.sh | sh
RUN yum install -y -q stns-v2 libnss-stns-v2

ADD server/stns.conf /etc/stns/server/stns.conf

CMD ["/usr/sbin/init"]
