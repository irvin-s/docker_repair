FROM ubuntu:precise
MAINTAINER kevin@pentabarf.net

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y qemu-kvm

RUN mkdir -p /root/qemu
ADD kvm-mknod.sh /root/qemu/kvm-mknod.sh
ADD entrypoint.sh /root/qemu/entrypoint.sh
RUN chmod +x /root/qemu/*.sh

ENTRYPOINT ["/root/qemu/entrypoint.sh"]
