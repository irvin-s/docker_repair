FROM scratch  
MAINTAINER Everton Ribeiro <nuxlli@gmail.com>  
  
ADD ./rootfs.tar /  
  
# Define mountable directories.  
VOLUME ["/data"]  
  
# Define working directory.  
WORKDIR /data  
  
# Define default command.  
CMD ["/bin/bash"]  
  
# Expose ports.  
EXPOSE 53/udp  
EXPOSE 80  

