# Builds a Docker image with Ubuntu FEniCS, Python3 and Jupyter Notebook  
# for "AMS 529: Finite Element Methods" at Stony Brook University  
#  
# Authors:  
# Xiangmin Jiao <xmjiao@gmail.com>  
# Use PETSc prebuilt in fastsolve/desktop  
FROM unifem/fenics-desktop  
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"  
  
USER root  
WORKDIR /tmp  
  
ADD image/home $DOCKER_HOME  
  
# Install Octave and Octave for Jupyter  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
octave \  
liboctave-dev \  
octave-info \  
octave-symbolic \  
octave-parallel \  
octave-struct && \  
apt-get clean && \  
apt-get autoremove && \  
pip3 install -U octave_kernel && \  
python3 -m octave_kernel.install && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
# Copy fenics-demo  
USER $DOCKER_USER  
ENV GIT_EDITOR=vi EDITOR=vi  
RUN echo 'export OMP_NUM_THREADS=$(nproc)' >> $DOCKER_HOME/.profile && \  
cp -r $FENICS_PREFIX/share/dolfin/demo $DOCKER_HOME/fenics-demo  
  
WORKDIR $DOCKER_HOME  
USER root  

