FROM centos:7  
MAINTAINER "Preston Norvell" <curator@shmoo.com>  
  
RUN yum -y install libguestfs-tools && yum -y update && yum clean all  
  
ENV LIBGUESTFS_BACKEND direct  
  
ENTRYPOINT ["/usr/bin/guestfish"]  
  
CMD ["-h"]  

