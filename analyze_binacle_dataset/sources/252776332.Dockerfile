FROM scratch  
ADD sl6x-x86_64-docker.tar.xz /  
  
LABEL name="Scientific Linux 6x x86_64 Base Image" \  
vendor="Scientific Linux" \  
license="GPLv2" \  
build-date="20170829"  
  
CMD ["/bin/bash"]  

