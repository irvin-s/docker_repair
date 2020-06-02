FROM fedora:23  
MAINTAINER Alex Smith <alex.smith@redhat.com>  
  
RUN dnf install -y tar && dnf clean all  

