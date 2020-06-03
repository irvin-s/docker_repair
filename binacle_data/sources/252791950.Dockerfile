FROM scratch  
MAINTAINER Takashi Takebayashi <changesworlds@gmail.com>  
ADD centos5.7-docker.tar.xz /  
LABEL name="CentOS Base Image" \  
vendor="CentOS" \  
license="GPLv2" \  
build-date="2016-06-08"  
  
# Default command  
CMD ["/bin/bash"]  

