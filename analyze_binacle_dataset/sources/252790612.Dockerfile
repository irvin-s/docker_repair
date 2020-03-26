FROM debian:stretch  
  
MAINTAINER carlowouters  
  
# Install samba  
RUN export DEBIAN_FRONTEND='noninteractive' && \  
apt-get update -qq && \  
apt-get install -qqy --no-install-recommends procps samba samba-vfs-modules\  
$(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\  
useradd -c 'Samba User' -d /tmp -M -r smbuser && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/*  
  
VOLUME ["/etc/samba"]  
  
COPY smb.conf /etc/samba/smb.conf  
COPY samba.sh /usr/bin/samba.sh  
RUN chmod 775 /usr/bin/samba.sh  
  
EXPOSE 137/udp 138/udp 139 445  
ENTRYPOINT ["/usr/bin/samba.sh"]  

