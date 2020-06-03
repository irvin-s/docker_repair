FROM ubuntu:14.04
RUN apt-get install -y nfs-kernel-server
VOLUME ["/export"]
