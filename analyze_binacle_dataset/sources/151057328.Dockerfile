# etcd
#
# VERSION    0.4.1

FROM       ubuntu:14.04
MAINTAINER Kelsey Hightower <kelsey.hightower@gmail.com>

# Download etcd from Github and install.
RUN apt-get install curl -y
RUN curl -s -k -L -o /tmp/etcd-v0.4.1-linux-amd64.tar.gz https://github.com/coreos/etcd/releases/download/v0.4.1/etcd-v0.4.1-linux-amd64.tar.gz
RUN tar -xvf /tmp/etcd-v0.4.1-linux-amd64.tar.gz
RUN mv etcd-v0.4.1-linux-amd64/etcd /usr/local/bin/etcd
RUN chown root:root /usr/local/bin/etcd
RUN chmod 755 /usr/local/bin/etcd

EXPOSE 4001 7001
ENTRYPOINT ["/usr/local/bin/etcd"]
