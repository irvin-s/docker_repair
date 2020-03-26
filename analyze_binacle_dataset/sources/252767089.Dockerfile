FROM ubuntu:18.04  
ENV container docker  
ENV DEBIAN_FRONTEND noninteractive  
ENV TERM xterm  
ENV LANG en_US.UTF-8  
ENV PATH "${PATH}:/opt/puppetlabs/bin"  
RUN apt-get update && \  
apt-get install -y systemd iputils-ping net-tools dnsutils openssh-server \  
build-essential apt-transport-https sudo locales unzip jq git wget vim  
  
RUN apt-get clean  
RUN rm -rf /var/lib/apt/lists/*  
  
RUN find /etc/systemd/system \  
/lib/systemd/system \  
-path '*.wants/*' \  
-not -name '*journald*' \  
-not -name '*systemd-tmpfiles*' \  
-not -name '*systemd-user-sessions*' \  
-exec rm \\{} \;  
  
RUN systemctl set-default multi-user.target  
RUN locale-gen en_US en_US.UTF-8  
RUN dpkg-reconfigure locales  
  
VOLUME ["/sys/fs/cgroup"]  
VOLUME ["/run"]  
  
CMD ["/sbin/init"]  

