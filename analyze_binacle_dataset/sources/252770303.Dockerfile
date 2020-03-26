FROM asgard/base:ubuntu1604  
  
# ###########################################################################  
# # Install good blas : OpenBlas  
# # From Olivier Grisel : https://github.com/ogrisel/docker-openblas  
# ###########################################################################  
  
ADD ./openblas/openblas.conf /etc/ld.so.conf.d/openblas.conf  
ADD ./openblas/build_openblas.sh build_openblas.sh  
RUN bash /build_openblas.sh  
  
# Clean up APT when done.  
RUN apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ENV BLAS /opt/OpenBLAS/lib/lipopenblas.so  
ENV LAPACK /opt/OpenBLAS/lib/lipopenblas.so  
  
# Init script  
ENTRYPOINT ["/sbin/my_init"]

