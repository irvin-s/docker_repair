#  
# A Debian Jessie container with helper scripts for installing packages  
#  
# todo: this is pretty much identical to baseboxorg/library-ubuntu  
#  
FROM ubuntu:16.04  
ADD ./src/docker-apt-install.sh /usr/local/sbin/docker-apt-install  
  
RUN chmod 500 \  
/usr/local/sbin/docker-apt-install  
  
RUN docker-apt-install \  
apt-utils  
  
# fix locale.  
ENV LANG en_US.UTF-8  
ENV LC_CTYPE en_US.UTF-8  
RUN docker-apt-install language-pack-en && \  
locale-gen en_US && \  
update-locale LANG=$LANG LC_CTYPE=$LC_CTYPE  
  
CMD ["/bin/bash", "-l"]  
  
# Rockerfiles have this, but don't work with Docker Hub  
# ATTACH ["/bin/bash", "-l"]  
# PUSH baseboxorg/library-debian:{{ $version }}  

