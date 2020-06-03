FROM 1of0/llvm  
  
VOLUME /var/ccache  
  
ADD ./ /var/build/  
WORKDIR /var/build  
  
RUN /bin/bash /var/build/.docker-build.sh

