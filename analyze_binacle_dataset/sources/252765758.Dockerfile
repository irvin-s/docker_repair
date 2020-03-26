FROM ubuntu:14.04  
MAINTAINER Marcus Hughes <hello@msh100.uk>  
  
# Update apt and install encfs  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update  
RUN apt-get install -y unionfs-fuse  
  
ADD mount.sh /  
RUN chmod +x /mount.sh  
  
CMD ["/mount.sh"]  
  

