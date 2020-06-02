# Spoke Dockerfile for pxe  
FROM radial/spoke-base:latest  
  
# Original author radial@brianclements.net  
MAINTAINER Bertrand Roussel <broussel@sierrawireless.com>  
  
# Install packages  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get -q update && apt-get -qyV install \  
dnsmasq wget syslinux host iptables &&\  
apt-get clean  
  
# Set Spoke ID  
ENV SPOKE_NAME pxe  
  
COPY /entrypoint.sh /entrypoint.sh  

