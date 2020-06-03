FROM ubuntu-debootstrap:14.04  
MAINTAINER Martijn van Maurik <docker@vmaurik.nl>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV HOME /root  
  
RUN apt-get update && apt-get dist-upgrade -yq  
  
RUN apt-get -qy install nfs-kernel-server runit inotify-tools  
  
RUN mkdir -p /exports  
  
RUN mkdir -p /etc/sv/nfs  
RUN rm -fr /etc/sv/getty-5  
ADD nfs.init /etc/sv/nfs/run  
ADD nfs.stop /etc/sv/nfs/finish  
ADD start.sh /usr/local/bin/start.sh  
  
RUN chmod +x /usr/local/bin/start.sh /etc/sv/nfs/finish /etc/sv/nfs/run  
  
VOLUME /exports  
  
EXPOSE 111/udp 2049/tcp  
  
CMD ["/usr/local/bin/start.sh"]  

