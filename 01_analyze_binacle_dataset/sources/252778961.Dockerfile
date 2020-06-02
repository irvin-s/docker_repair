FROM ubuntu:12.10  
MAINTAINER Burl Nyswonger <bnyswonger@marchex.com>  
RUN locale-gen --no-purge en_US.UTF-8  
ENV LC_ALL en_US.UTF-8  
ENV DEBIAN_FRONTEND noninteractive  
ENV DEBIAN_PRIORITY critical  
ENV DEBCONF_NOWARNINGS yes  
RUN apt-get update  
  
#  
ADD files /tmp  
  
RUN apt-get install -yy git curl bzip2 sudo  
RUN bash /tmp/install-node  
RUN rm /tmp/install-node  
  
# CMD su - node  

