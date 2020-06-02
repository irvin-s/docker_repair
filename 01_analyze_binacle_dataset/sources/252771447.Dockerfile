FROM fedora:23  
MAINTAINER Alex Smith <alex.smith@redhat.com>  
  
RUN dnf install -y tmpwatch && dnf clean all  
  
ENTRYPOINT ["/usr/bin/tmpwatch"]  

