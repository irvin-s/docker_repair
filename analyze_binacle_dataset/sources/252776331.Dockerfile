FROM scratch  
ADD sl-6x-x86_64-docker.tar.xz /  
  
LABEL name="Scientific Linux 6x x86_64 Base Image" \  
vendor="Scientific Linux" \  
license="GPLv2" \  
build-date="201708229"  
  
CMD ["/bin/bash"]  

