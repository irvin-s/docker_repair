FROM fedora:latest  
MAINTAINER Arun Babu Neelicattu <arun.neelicattu@gmail.com>  
  
# Source: https://vpavlin.eu/2015/02/fedora-docker-and-systemd/  
ENV container=docker  
  
RUN yum -y update; yum -y clean all  
  
# mask what we dont need  
RUN systemctl mask systemd-remount-fs.service \  
dev-hugepages.mount \  
sys-fs-fuse-connections.mount \  
systemd-logind.service \  
getty.target \  
console-getty.service  
  
# fix up dbus  
RUN cp /usr/lib/systemd/system/dbus.service /etc/systemd/system/  
RUN sed -i 's/OOMScoreAdjust=-900//' /etc/systemd/system/dbus.service  
  
VOLUME ["/sys/fs/cgroup", "/run", "/tmp"]  
  
CMD ["/usr/sbin/init"]  
  
ONBUILD RUN yum -y update; yum -y clean all  

