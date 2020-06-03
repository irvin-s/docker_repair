FROM centos:latest  
MAINTAINER "Alphayax <alphayax@gmail.com>"  
# Install nfs-utils  
RUN yum -y install /usr/bin/ps nfs-utils && yum clean all  
  
# Copy entrypoint  
ADD run_nfs.sh /usr/local/bin/run_nfs.sh  
  
# Create exports dir  
RUN mkdir -p /exports \  
&& chmod +x /usr/local/bin/run_nfs.sh  
  
# Export NFS Ports  
EXPOSE 20048/tcp 2049/tcp  
  
# Expose volume  
VOLUME /exports  
  
# Launch entrypoint  
ENTRYPOINT ["/usr/local/bin/run_nfs.sh"]  
  
CMD ["/exports"]  
  

