FROM fedora:27  
MAINTAINER Christopher Antila <christopher@ncodamusic.org>  
  
# Use a script to configure the container. This way we can  
# split up the operations and do it all in a single layer.  
COPY scripts/ /tmp/  
RUN /tmp/run_container.sh  
  
VOLUME [ "/sys/fs/cgroup", "/tmp", "/run" ]  

