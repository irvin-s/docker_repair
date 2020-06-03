FROM golang:1  
#install petsc  
ENV PETSC_DOWNLOAD_URL http://ftp.mcs.anl.gov/pub/petsc/petsc-lite.tar.gz  
ENV PETSC_ARCH arch-linux2-c-opt  
ENV PETSC_DIR /usr/local/petsc  
ENV PETSC_LIB $PETSC_DIR/$PETSC_ARCH/lib/  
ENV LD_LIBRARY_PATH $PETSC_LIB:$LD_LIBRARY_PATH  
RUN set -eux; \  
cd $PETSC_DIR/..; \  
curl -fsSL "$PETSC_DOWNLOAD_URL" -o petsc.tar.gz; \  
tar -xzf petsc.tar.gz; \  
rm petsc.tar.gz; \  
mv petsc* petsc; \  
cd $PETSC_DIR; \  
./configure --with-cc=gcc --with-cxx=0 \--with-fc=0 \--with-debugging=0 \  
# Optimization: if compiled somewhere, may not work elsewhere.  
# COPTFLAGS='-O3 -march=native -mtune=native' \  
\--download-mpich --download-f2cblaslapack; \  
make all test; \  
rm -rf /tmp/* /var/tmp/*;

