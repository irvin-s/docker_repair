FROM fedora:21  
MAINTAINER Russ Harmon <eatnumber1@gmail.com>  
  
# Install prerequisites.  
RUN yum -y install nfs-utils fuse python-setuptools  
RUN yum clean all  
  
# Install supervisord  
RUN easy_install -O2 supervisor supervisor-stdout  
ADD etc/supervisord.conf /etc/  
ADD etc/supervisord.d /etc/supervisord.d  
  
# Install NFS  
ADD etc/exports /etc/  
ADD bin /opt/bin  
  
# Install ObjectiveFS  
ADD bin/mount.objectivefs /sbin/  
RUN chmod +x /sbin/mount.objectivefs  
RUN mkdir /objectivefs  
RUN mkdir /envdir  
  
# nfs  
EXPOSE 2049/tcp 2049/udp  
# rpcbind  
EXPOSE 111/tcp 111/udp  
# nfs_callback_tcpport  
EXPOSE 1066/tcp  
# mountd  
EXPOSE 1067/tcp 1067/udp  
  
ENTRYPOINT ["/opt/bin/start_supervisord"]  

