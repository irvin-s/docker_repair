FROM azedarach/fedora-gcc  
LABEL maintainer "dylan.harries@adelaide.edu.au"  
  
RUN dnf update -y --setopt=deltarpm=false \  
&& dnf install --setopt=deltarpm=false -y \  
alglib-devel \  
boost-devel \  
cmake \  
eigen3-devel \  
ginac-devel \  
NLopt-devel \  
&& dnf clean all  

