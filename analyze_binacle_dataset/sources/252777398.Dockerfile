#  
# PSI4 Dockerfile  
#  
# http://psicode.org/psi4manual/master/index.html  
#  
# https://github.com/cgsanchez/ScienceContainers/Psi4  
#  
#  
FROM ubuntu:14.04  
MAINTAINER Cristian G. Sanchez <cgs@cgsanchez.net>  
  
#  
# internal labels  
#  
LABEL "net.cgsanchez.code"="psi4"  
LABEL "net.cgsanchez.version"="4.0b5"  
  
#  
# Download and install miniconda  
#  
ADD http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh /root/  
WORKDIR /root  
  
RUN bash Miniconda-latest-Linux-x86_64.sh -b -p /miniconda && \  
rm Miniconda-latest-Linux-x86_64.sh  
  
ENV PATH /miniconda/bin/:$PATH  
  
#  
# Update miniconda, add psi4 conda repository and install psi4  
#  
RUN \  
conda update --yes --all && \  
conda config --add channels http://conda.anaconda.org/psi4 && \  
conda install --yes psi4  
  
#  
# The scratch_dir should be used for scratch files, mounted at runtime  
# Teh run_dir would contain teh input and output files, mounted at runtime  
#  
VOLUME /scratch_dir  
VOLUME /run_dir  
  
#  
# Set one thread by default, can be overriden at runtime  
#  
ENV MKL_NUM_THREADS=1  
ENV OMP_NUM_THREADS=1  
#  
# Point scratch space to mounted scratch directory  
#  
ENV PSI_SCRATCH=/scratch_dir  
#  
# Set name of input file, can be overriden at runtime  
#  
ENV INP_FILE_NAME=psi4.inp  
  
WORKDIR /run_dir  
  
ENTRYPOINT /miniconda/bin/psi4 $INP_FILE_NAME  

