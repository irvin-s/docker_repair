FROM alpine:3.5  
MAINTAINER Adam Eilers <adam.eilers@gmail.com>  
  
ENV FSTYPE="nfs4" \  
MOUNT_OPTIONS="nfsvers=4" \  
MOUNTPOINT="/mnt/nfs"  
RUN apk update \  
&& apk add nfs-utils \  
&& rm -rf /var/cache/apk/* \  
&& rm /sbin/halt /sbin/poweroff /sbin/reboot  
  
ADD entry.sh /usr/local/bin/entry.sh  
  
ENTRYPOINT ["/usr/local/bin/entry.sh"]  

