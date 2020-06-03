FROM fedora:latest  
MAINTAINER Darksheer  
  
RUN dnf clean all && dnf update -y && dnf clean all  

