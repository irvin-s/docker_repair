FROM fedora:25  
MAINTAINER Darksheer  
  
RUN dnf clean all && dnf update -y && dnf clean all  

