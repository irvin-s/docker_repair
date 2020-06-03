FROM phusion/baseimage:latest  
MAINTAINER Alexander Reece <alreece45@gmail.com>  
  
# Install packages first  
COPY ./phusion_trusty/installer /opt/icinga2-installer  
RUN /opt/incinga2-installer/packages.sh  
  
# Setup the packages  
COPY ./phusion_trusty/setup /opt/icinga2-setup  
RUN /opt/icinga2-setup/setup.sh  

