FROM ubuntu:trusty
MAINTAINER Ian Blenke <ian@blenke.com>

RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install kvm qemu-kvm libvirt-bin bridge-utils libguestfs-tools aria2 unzip dos2unix unrar-free wget git

ADD run.sh /run.sh
RUN chmod +x /run.sh

EXPOSE 3389
EXPOSE 5900

VOLUME /etc/libvirt
VOLUME /var/lib/libvirt

CMD /run.sh
