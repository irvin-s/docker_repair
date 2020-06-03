FROM cogentwebs/base  
MAINTAINER Pichate Ins <cogent@cogentwebworks.com>  
  
# Set labels  
LABEL com.nfs4.cogentwebworks.version="0.1.1-beta"  
  
# Install nfs4  
RUN apk-install nfs-utils && apk-clean  
  
# ROOTFS  
COPY rootfs /  
  
# Expose the ports for nfs  
EXPOSE 111/tcp 111/udp 2049/tcp 2049/udp  
  
# INIT S6  
ENTRYPOINT [ "/init" ]

