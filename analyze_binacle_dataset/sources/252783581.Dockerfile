FROM alpine:3.5  
RUN apk add --no-cache tftp-hpa syslinux  
  
WORKDIR /srv/tftp/  
RUN cp -a /usr/share/syslinux ./  
RUN ln -s syslinux/pxelinux.0  
RUN wget http://releases.rancher.com/os/v0.7.1/vmlinuz  
RUN wget http://releases.rancher.com/os/v0.7.1/initrd  
  
VOLUME /srv/tftp/pxelinux.cfg  
EXPOSE 69/udp  

