FROM fedora:23  
MAINTAINER Darksheer  
  
RUN dnf clean all && dnf update -y && dnf clean all

