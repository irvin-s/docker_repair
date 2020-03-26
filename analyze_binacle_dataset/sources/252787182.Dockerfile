# test-kitchen  
#  
# Ubuntu 14.04 image fully provisioned and ready for chef test-kitchen  
FROM ubuntu:14.04  
MAINTAINER Nicola Brisotto  
  
RUN dpkg-divert --local \--rename --add /sbin/initctl  
RUN ln -sf /bin/true /sbin/initctl  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update  
RUN apt-get install -y sudo openssh-server curl lsb-release  
  
RUN useradd -d /home/kitchen -m -s /bin/bash kitchen  
RUN echo kitchen:kitchen | chpasswd  
RUN echo 'kitchen ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers  
RUN curl -L https://www.opscode.com/chef/install.sh | bash  

