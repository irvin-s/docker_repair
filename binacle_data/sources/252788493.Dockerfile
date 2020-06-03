# Docker Image to build the CRUX ISO  
FROM crux/base:latest  
MAINTAINER James Mills, prologic at shortcircuit dot net dot au  
  
# Volumes  
VOLUME /mnt/media  
  
# Startup  
CMD ["./build.sh"]  
  
# Configuration  
ENV NAME crux  
ENV VERSION 3.1  
ENV URL http://ftp.morpheus.net/pub/linux/crux  
ENV MEDIA /mnt/media  
  
# Build/Runtime Dependencies  
RUN ports -u && \  
prt-get cache && \  
prt-get depinst elinks esmtp git grhub2 grub2-efi pciutils  
  
# Application  
WORKDIR /usr/src  
RUN git clone git://crux.nu/system/iso.git  
  
WORKDIR iso  
RUN git checkout ${VERSION}  
  
WORKDIR ports  
RUN git clone git://crux.nu/ports/core.git && \  
git clone git://crux.nu/ports/opt.git && \  
git clone git://crux.nu/ports/xorg.git && \  
(cd core; git checkout ${VERSION}) && \  
(cd opt; git checkout ${VERSION}) && \  
(cd xorg; git checkout ${VERSION})  
  
WORKDIR /usr/src/iso  
RUN prt-get depinst $(cat packages.opt)  
RUN prt-get depinst $(cat packages.xorg)  

