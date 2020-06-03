FROM fedora:24  
MAINTAINER Darksheer  
  
RUN dnf clean all && dnf update -y && dnf clean all  

