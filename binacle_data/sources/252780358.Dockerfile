# Use phusion/baseimage as base image. To make your builds reproducible, make  
# sure you lock down to a specific version, not to `latest`!  
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for  
# a list of version numbers.  
FROM phusion/baseimage:0.9.17  
# Use baseimage-docker's init system.  
CMD ["/sbin/my_init"]  
  
RUN groupadd -r alpha \  
&& useradd -r -g alpha -G sudo alpha  
  
RUN apt-get update  
RUN apt-get -y upgrade  
  
RUN rm -f /etc/service/sshd/down  
  
# Regenerate SSH host keys. baseimage-docker does not contain any, so you  
# have to do that yourself. You may also comment out this instruction; the  
# init system will auto-generate one during boot.  
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh  
  
## Install Volumes  
EXPOSE 22  
# Clean up APT when done.  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

