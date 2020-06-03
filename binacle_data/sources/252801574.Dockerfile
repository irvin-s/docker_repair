FROM fedora:23  
MAINTAINER Russ Harmon <eatnumber1@gmail.com>  
  
# Install prerequisites.  
RUN dnf -y install nfs-utils python-setuptools procps-ng zsh  
RUN dnf clean all  
  
# Install supervisord  
RUN easy_install -O2 supervisor supervisor-stdout  
ADD etc/supervisord.conf /etc/  
ADD etc/supervisord.d /etc/supervisord.d  
  
# Install NFS  
ADD etc/exports /etc/  
ADD bin /opt/bin  
RUN mkdir /export  
  
# nfs  
EXPOSE 2049/tcp 2049/udp  
# rpcbind  
EXPOSE 111/tcp 111/udp  
# nfs_callback_tcpport  
EXPOSE 1066/tcp  
# mountd  
EXPOSE 1067/tcp 1067/udp  
  
ENTRYPOINT ["/opt/bin/start_supervisord"]  

