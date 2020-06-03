FROM fedora:28  
  
RUN yum install -y \  
cmake \  
gcc-c++ \  
git \  
make \  
pythia8-devel \  
root \  
root-genvector \  
root-graf3d-eve \  
root-montecarlo-eg \  
tcl \  
wget \  
which \  
zlib-devel  
  
COPY ROOTConfig-targets-relwithdebinfo.cmake /usr/share/root/cmake/  

