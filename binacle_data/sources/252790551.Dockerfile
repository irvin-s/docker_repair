FROM ubuntu:14.04  
MAINTAINER Haiwei Liu <carllhw@gmail.com>  
  
RUN set -x \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends \  
inotify-tools \  
nfs-kernel-server \  
runit  
  
RUN mkdir -p /exports  
RUN mkdir -p /etc/sv/nfs  
ADD nfs_init.sh /etc/sv/nfs/run  
ADD nfs_stop.sh /etc/sv/nfs/finish  
  
ADD nfs_setup.sh /usr/local/bin/nfs_setup  
  
VOLUME /exports  
  
EXPOSE 111/udp 2049/tcp  
  
ENTRYPOINT ["/usr/local/bin/nfs_setup"]  

