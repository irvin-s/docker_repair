FROM centos:7  
RUN yum -y update; yum -y install epel-release  
RUN yum -y update && yum -y install \  
initscripts \  
python-pip \  
&& yum clean all  
  
RUN yum -y swap -- remove systemd-container systemd-container-libs \  
\-- install systemd systemd-libs dbus fsck.ext4  
  
RUN systemctl mask dev-mqueue.mount dev-hugepages.mount \  
systemd-remount-fs.service sys-kernel-config.mount \  
sys-kernel-debug.mount sys-fs-fuse-connections.mount \  
display-manager.service graphical.target systemd-logind.service  
  
ADD dbus.service /etc/systemd/system/dbus.service  
RUN systemctl enable dbus.service  
  
VOLUME ["/sys/fs/cgroup"]  
VOLUME ["/run"]  
  
RUN pip install ansible ansible-lint  
RUN curl -fsSL https://goss.rocks/install | sh  
  
WORKDIR /ansible  
  
CMD ["/usr/sbin/init"]  

