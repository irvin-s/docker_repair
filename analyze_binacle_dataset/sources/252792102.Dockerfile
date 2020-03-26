# RTP Server Dockerfile  
# Pull base image  
FROM centos:7  
# Maintainer  
MAINTAINER chason.du@nokia-sbell.com  
  
# Copy file  
ADD rtp_server /usr/bin/  
  
# Entrypoint  
CMD ["/usr/bin/rtp_server"]  
  

