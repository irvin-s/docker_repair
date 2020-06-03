# Builds a Docker image for PETSc and SLEPC  
#  
# Authors:  
# Xiangmin Jiao <xmjiao@gmail.com>  
  
FROM x11vnc/desktop:latest  
LABEL maintainer "Xiangmin Jiao <xmjiao@gmail.com>"  
  
USER root  
WORKDIR /tmp  
  
ENV PETSC_VERSION=3.7.6  
ENV SLEPC_VERSION=3.7.4  
# Install system packages  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
build-essential \  
cmake \  
gcc \  
gfortran \  
bison \  
flex \  
git \  
bash-completion \  
bsdtar \  
rsync \  
wget \  
gdb \  
ccache \  
\  
libopenblas-base \  
libopenblas-dev \  
\  
openmpi-bin libopenmpi-dev \  
libscalapack-openmpi1 libscalapack-mpi-dev \  
libsuperlu-dev \  
libsuitesparse-dev \  
libhypre-dev \  
libblacs-openmpi1 libblacs-mpi-dev \  
libptscotch-dev \  
libmumps-dev \  
\  
libpetsc${PETSC_VERSION}-dev \  
libslepc${SLEPC_VERSION}-dev && \  
apt-get clean && \  
apt-get autoremove && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ENV PETSC_DIR=/usr/lib/petscdir/${PETSC_VERSION}/x86_64-linux-gnu-real  
ENV SLEPC_DIR=/usr/lib/slepcdir/${SLEPC_VERSION}/x86_64-linux-gnu-real  
  
########################################################  
# Customization for user  
########################################################  
RUN echo "export OMP_NUM_THREADS=\$(nproc)" >> $DOCKER_HOME/.profile && \  
chown -R $DOCKER_USER:$DOCKER_GROUP $DOCKER_HOME  
  
WORKDIR $DOCKER_HOME  

